Return-Path: <SRS0=6njX=RW=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403DBC43381
	for <linux-iio@archiver.kernel.org>; Tue, 19 Mar 2019 20:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF7F2146E
	for <linux-iio@archiver.kernel.org>; Tue, 19 Mar 2019 20:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfCSUqy (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:46:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:20829 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbfCSUqy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Mar 2019 16:46:54 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 13:46:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,246,1549958400"; 
   d="p7s'?scan'208";a="330096775"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga005.fm.intel.com with ESMTP; 19 Mar 2019 13:46:54 -0700
Received: from orsmsx109.amr.corp.intel.com ([169.254.11.11]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.204]) with mapi id 14.03.0415.000;
 Tue, 19 Mar 2019 13:46:52 -0700
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "jic23@jic23.retrosnub.co.uk" <jic23@jic23.retrosnub.co.uk>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "hadess@hadess.net" <hadess@hadess.net>
Subject: Re: Debugging 3D sensor on Lenovo YOGA 700-11ISK
Thread-Topic: Debugging 3D sensor on Lenovo YOGA 700-11ISK
Thread-Index: AQHU3CbSy/88SJFrT0i65NWQX4BOOaYQfPeAgACGHgCAAJT9gIAAa3MAgAB+EoCAABFhgIAADDkAgAFHmYA=
Date:   Tue, 19 Mar 2019 20:46:50 +0000
Message-ID: <363e9402f977dcc56098924a3e230cd8e0ce846a.camel@intel.com>
References: <eb33acca-f48d-a689-c5e7-6f9b66f50caf@ozlabs.ru>
         <20190316183348.76573887@archlinux>
         <b6795bcb3d1c6e827c256e9c16f6e582b29358fc.camel@intel.com>
         <7552a684-90ea-2066-ef0b-4e25390b6d55@ozlabs.ru>
         <d5773e94-043a-2971-2c2e-2838b9105df2@ozlabs.ru>
         <5a5759a9217baf5eb1fe0c63414260f0d599e81c.camel@intel.com>
         <9785207e-10e0-3960-04e7-505068653be7@ozlabs.ru>
         <34ec1627c21f1582cea9088598014820d0eaef5d.camel@intel.com>
         <2655ef88-da2a-1c7e-045c-c61e821329fd@ozlabs.ru>
In-Reply-To: <2655ef88-da2a-1c7e-045c-c61e821329fd@ozlabs.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.31]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-5Jizf3E113JbWuhDmqXW"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--=-5Jizf3E113JbWuhDmqXW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-03-19 at 12:14 +1100, Alexey Kardashevskiy wrote:
>=20

[...]

> Refer to iio buffer interface for how to read from buffers by
> > enabling
> > channels. tools/iio/iio_generic_buffer.c is an example how to use.
>=20
>=20
> No, my question was about the kernel side of the device, not the
> userspace, it is late to look there - the data seems to be broken. I
> am
> interested to see how these buffers are filled with data and compare
> to
> what linux exposes via in_accel_x_raw sysops properties. Oh well, it
> is
> debugging time them.
kernel processing is done in multiple layers, from transport->hid-
sensor-hub.c->hid-sensor-accel-3d.c
The kernel is just sending what FW is sending in buffer mode.
FW is sending 0,0,0 for x,y,z. This is the way FW is telling that it
completed a batch. Basically the user space could have gone to sleep by
informing that don't bother it for x amount of time or samples. It
seems that this platform is enabling batch mode, whether user space
wants it or not.

Try this change iio-sensor-proxy. From raw data=20

diff --git a/src/drv-iio-buffer-accel.c b/src/drv-iio-buffer-accel.c
index ebf94de..84a83a3 100644
--- a/src/drv-iio-buffer-accel.c
+++ b/src/drv-iio-buffer-accel.c
@@ -65,6 +65,11 @@ process_scan (IIOSensorData data, DrvData *or_data)
        tmp.y =3D accel_y;
        tmp.z =3D accel_z;
=20
+       if (tmp.x =3D=3D 0 && tmp.y =3D=3D 0 && tmp.z =3D=3D 0) {
+               g_debug("batch complete\n");
+               return 0;
+       }
+
        if (!apply_mount_matrix (or_data->mount_matrix, &tmp))
                g_warning ("Could not apply mount matrix");
=20

Thanks,
Srinivas


>=20
>=20
>=20

--=-5Jizf3E113JbWuhDmqXW
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
zFtUc0whb39jT7klbqWD26anBZ8LZsRmaU2FylSgaQm5IMl6ILV2cDVhBitGeKIwNYMqpcLejOnr
Zbrn3/QvAgMBAAGjggI9MIICOTAdBgNVHQ4EFgQUBdulS2EQ0eFtMXDEFoVPVLcb8dwwHwYDVR0j
BBgwFoAUHmkqtNwo/kcYTiELP7ysES/wmPUwZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5p
bnRlbC5jb20vcmVwb3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWlu
ZyUyMENBJTIwNEEuY3JsMIGfBggrBgEFBQcBAQSBkjCBjzBpBggrBgEFBQcwAoZdaHR0cDovL3d3
dy5pbnRlbC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJh
c2ljJTIwSXNzdWluZyUyMENBJTIwNEEuY3J0MCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5pbnRl
bC5jb20vMAsGA1UdDwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9
gSiFjp9TgpHACWeB3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMM
MCkGCSsGAQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBXBgNVHREEUDBOoC0G
CisGAQQBgjcUAgOgHwwdc3Jpbml2YXMucGFuZHJ1dmFkYUBpbnRlbC5jb22BHXNyaW5pdmFzLnBh
bmRydXZhZGFAaW50ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQC3BC7joH3dX6x9O8HsMgJ8DgZp
OnY6eG3DVzJSonWr++Pv4CRQ6wh+J7bH3hTBq+tb2xbe2ZAfudqX/gezisOufHOKm0gs1UGBxFdj
snEt87sD096N34r2lE1tUDyPARQNKangT4IFJ273PSYg2zlbbJYoWeOq76SS3SfcH58FsAO5d70d
cCAW38N1mc+LWHBnEEN3dfFrNQgZSiqZ8jenu/a3FhqbhIMZbwa/Zlnuz8LPUIrjiEblAhmab3m4
B+Dg1xocVmrPOrLbjxwULJldJEDvhwXzEeFCdTPp2/0O28Jmi0Upxb3QBfhczCcZ95/H6X6gQdfW
89/DPXl9Dl4IMYICFzCCAhMCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYD
VQQHEwtTYW50YSBDbGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIklu
dGVsIEV4dGVybmFsIEJhc2ljIElzc3VpbmcgQ0EgNEECEzMAAMcBCehwTtyBUDoAAAAAxwEwCQYF
Kw4DAhoFAKBdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDMx
OTIwNDY0OVowIwYJKoZIhvcNAQkEMRYEFNpOqRUtuihr1etsGUC+EKjWGn1sMA0GCSqGSIb3DQEB
AQUABIIBAELm/AliQcLD0nh1LFuR3vZuHUcaa4LtC+KXnvrrI5FjjSeqH3LTyij/b9o6dsDt1QEC
jkrSF//MD3ySuzild4iXlXabB6y5JbbfHLBHG0myK/jtOuanJdLDG+bfZILUphBMsLy/ZpiSqFqT
1QopgfFoJejnUKBy3bVpIoq04+vZRCmBN71Y39SAhUyY/M9R3H5AjLSOl4OUfWSIyE4cCQznBXQc
I4i6PamrnkupBw2pSAKPAO++PgA1gKDzJwSSugkTqVLj6z5DJbXOGt1M0pI28u4hEWVg0WG4KJ1Q
zsTDF5lvkz7Ai45dIR8dE+Ptot8Er0K8HczKQKzmIrPSgpcAAAAAAAA=


--=-5Jizf3E113JbWuhDmqXW--
