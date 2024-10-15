{ fetchurl, lib, vboxlocal}:

let
  inherit (vboxlocal) version;
in
fetchurl {
  url = "http://download.virtualbox.org/virtualbox/${version}/VBoxGuestAdditions_${version}.iso";
  sha256 = "d03217fcb361fa8634807e9e8a99e818ddb537fe8b9c413ec26f1509f1a048a3";
  meta = {
    description = "Guest additions ISO for VirtualBox";
    longDescription = ''
      ISO containing various add-ons which improves guests inside VirtualBox.
    '';
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    license = lib.licenses.gpl2;
    maintainers = [ lib.maintainers.sander lib.maintainers.friedrichaltheide ];
    platforms = [ "i686-linux" "x86_64-linux" ];
  };
}
