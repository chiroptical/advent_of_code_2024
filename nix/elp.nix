{
  stdenv,
  lib,
  fetchurl,
  autoPatchelfHook,
}:
let
  arch = if stdenv.hostPlatform.isAarch64 then "aarch64" else "x86_64";
  release =
    if stdenv.hostPlatform.isDarwin then
      "macos-${arch}-apple-darwin"
    else
      "linux-${arch}-unknown-linux-gnu";

  hashes = {
    linux-aarch64-unknown-linux-gnu = "sha256-0000000000000000000000000000000000000000000=";
    linux-x86_64-unknown-linux-gnu = "sha256-UU4IOBn0J+mpEHg4jKi1483cVWaVzdHBVrfOSz4+PXo=";
    macos-aarch64-apple-darwin = "sha256-VNiBrfBYNXf2dSlHOYrgXsb8Lk+5A+Onqz/Pe+5P5Xk=";
    macos-x86_64-apple-darwin = "sha256-0000000000000000000000000000000000000000000=";
  };
in
stdenv.mkDerivation rec {
  pname = "erlang-language-platform";
  version = "2024-12-09";

  src = fetchurl {
    url = "https://github.com/WhatsApp/erlang-language-platform/releases/download/${version}/elp-${release}-otp-27.1.tar.gz";
    hash = hashes.${release};
  };

  nativeBuildInputs = lib.optionals stdenv.hostPlatform.isElf [ autoPatchelfHook ];

  buildInputs = lib.optionals stdenv.hostPlatform.isElf [ (lib.getLib stdenv.cc.cc) ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    install -m755 -D elp $out/bin/elp
    runHook postInstall
  '';

  meta = {
    description = "An IDE-first library for the semantic analysis of Erlang code, including LSP server, linting and refactoring tools.";
    homepage = "https://github.com/WhatsApp/erlang-language-platform/";
    license = with lib.licenses; [
      mit
      asl20
    ];
    platforms = [
      "aarch64-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    maintainers = with lib.maintainers; [ offsetcyan ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
}
