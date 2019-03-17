Return-Path: <SRS0=squ6=RU=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728E5C43381
	for <linux-iio@archiver.kernel.org>; Sun, 17 Mar 2019 16:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C662087C
	for <linux-iio@archiver.kernel.org>; Sun, 17 Mar 2019 16:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfCQQjW (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 17 Mar 2019 12:39:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:17192 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfCQQjW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Mar 2019 12:39:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Mar 2019 09:39:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,490,1544515200"; 
   d="p7s'?scan'208";a="135082856"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga007.fm.intel.com with ESMTP; 17 Mar 2019 09:39:21 -0700
Received: from orsmsx159.amr.corp.intel.com (10.22.240.24) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 17 Mar 2019 09:39:21 -0700
Received: from orsmsx109.amr.corp.intel.com ([169.254.11.11]) by
 ORSMSX159.amr.corp.intel.com ([169.254.11.117]) with mapi id 14.03.0415.000;
 Sun, 17 Mar 2019 09:39:20 -0700
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "jic23@jic23.retrosnub.co.uk" <jic23@jic23.retrosnub.co.uk>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "hadess@hadess.net" <hadess@hadess.net>
Subject: Re: Debugging 3D sensor on Lenovo YOGA 700-11ISK
Thread-Topic: Debugging 3D sensor on Lenovo YOGA 700-11ISK
Thread-Index: AQHU3CbSy/88SJFrT0i65NWQX4BOOaYQfPeA
Date:   Sun, 17 Mar 2019 16:39:19 +0000
Message-ID: <b6795bcb3d1c6e827c256e9c16f6e582b29358fc.camel@intel.com>
References: <eb33acca-f48d-a689-c5e7-6f9b66f50caf@ozlabs.ru>
         <20190316183348.76573887@archlinux>
In-Reply-To: <20190316183348.76573887@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.139.14]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-UWoft9krd6T/kOhI/qF2"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--=-UWoft9krd6T/kOhI/qF2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2019-03-16 at 18:33 +0000, Jonathan Cameron wrote:
> +CC bastien and (guessing it is a HID sensor) Srinivas.
> On Sat, 16 Mar 2019 20:16:39 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
> > Hi!
> >=20
> > I got a quite old Lenovo YOGA 700-11ISK with flip screen and run
> > fedora29 on it. I found that gnome3 cannot properly detect the
> > screen
> > orientation and the screen keeps rotating non stop.
> >=20
> > I opened an issue agains iio-sensor-proxy, not much luck there.
> > https://github.com/hadess/iio-sensor-proxy/issues/220
> >=20
> > I resumed my debugging and the situation seems improving.
> >=20
> > The yoga is running fedora29 v4.20.14. The fedora's iio-sensor-
> > proxy
> > still has this problem and so does the iio-sensor-proxy upstream
> > version.
> >=20
> > Then I commented out &iio_buffer_accel to make &iio_poll_accel work
> > -
> > and things worked nicely. I looked in sysfs and in_accel_?_raw seem
> > to
> > have correct values (same as in the first log below, give or take),
> > all
> > good. Recorded some debug from iio-sensor-proxy:
> >=20
> > Accel read from IIO on 'accel_3d': -39, -937, -378 (scale 0.009807)
> > Accel sent by driver (quirk applied): -39, -937, -378 (scale:
> > 0.009807)
> > Emitted orientation changed: from undefined to normal
> > No new data available on 'iio:device3'
> > Accel read from IIO on 'accel_3d': -39, -933, -371 (scale 0.009807)
> > Accel sent by driver (quirk applied): -39, -933, -371 (scale:
> > 0.009807)
> > No new data available on 'iio:device3'
> > Accel read from IIO on 'accel_3d': -39, -933, -367 (scale 0.009807)
> > Accel sent by driver (quirk applied): -39, -933, -367 (scale:
> > 0.009807)
> >=20
> > This is the good log, gnome works fine.
> >=20
> >=20
> > Then I recorded debug with the buffer driver enabled:
> >=20
> > rocess_scan_1: channel_index: 0, chan_name: in_accel_x,
> > channel_data_index: 0 location: 0
> > process_scan_1: channel_index: 1, chan_name: in_accel_y,
> > channel_data_index: 1 location: 4
> > process_scan_1: channel_index: 2, chan_name: in_accel_z,
> > channel_data_index: 2 location: 8
> > Accel read from IIO on 'iio:device4': -15, -898, -375 (scale
> > 0.009807)
> > Accel sent by driver (quirk applied): -15, -898, -375 (scale:
> > 0.009807)
> > Emitted orientation changed: from undefined to normal
> > No new data available on 'iio:device3'
> > process_scan_1: channel_index: 0, chan_name: in_accel_x,
> > channel_data_index: 0 location: 0
> > process_scan_1: channel_index: 1, chan_name: in_accel_y,
> > channel_data_index: 1 location: 4
> > process_scan_1: channel_index: 2, chan_name: in_accel_z,
> > channel_data_index: 2 location: 8
> > Accel read from IIO on 'iio:device4': 20774, 27203, 0 (scale
> > 0.009807)
> > Accel sent by driver (quirk applied): 20774, 27203, 0 (scale:
> > 0.009807)
> > Emitted orientation changed: from normal to left-up
> > No new data available on 'iio:device3'
> > process_scan_1: channel_index: 0, chan_name: in_accel_x,
> > channel_data_index: 0 location: 0
> > process_scan_1: channel_index: 1, chan_name: in_accel_y,
> > channel_data_index: 1 location: 4
> > process_scan_1: channel_index: 2, chan_name: in_accel_z,
> > channel_data_index: 2 location: 8
> > Accel read from IIO on 'iio:device4': -31, -929, -398 (scale
> > 0.009807)
> > Accel sent by driver (quirk applied): -31, -929, -398 (scale:
> > 0.009807)
> > Emitted orientation changed: from left-up to normal
> > No new data available on 'iio:device3'
> > process_scan_1: channel_index: 0, chan_name: in_accel_x,
> > channel_data_index: 0 location: 0
> > process_scan_1: channel_index: 1, chan_name: in_accel_y,
> > channel_data_index: 1 location: 4
> > process_scan_1: channel_index: 2, chan_name: in_accel_z,
> > channel_data_index: 2 location: 8
> > Accel read from IIO on 'iio:device4': -14345, -32024, 12738 (scale
> > 0.009807)
> > Accel sent by driver (quirk applied): -14345, -32024, 12738 (scale:
> > 0.009807)
> >=20
> > So it is good reading, bad reading, good reading, bad reading, and
> > gnome
> > rotates the screen non stop. No wonder gnome3 goes crazy.
I suppose you don't move the screen. Try this to see if there is some
conversion errors in iio-sensor-proxy in some cases. Raw data is a
simply push from firmware, without any conversion..

rename /usr/sbin/iio-sensor-proxy for test only. Then reboot.
As part of linux kernel git, tools/iio, build iio-generic-buffer.

#sudo ./iio_generic_buffer -l 1 -a -c 100 -n accel_3d'


Thanks,
Srinivas

> >=20
> > I would debug further and even come up with a fix but I failed to
> > find
> > quickly where there reads are handled in the kernel, and what
> > defines
> > these in_accel_?_raw files in sysfs, tried grepping - nothing. Any
> > pointers?


>=20
> The raw files are built by the IIO core to call the read_raw callback
> in the
> each driver.  The path for buffered data is very different.
> Ultimately
> it goes through a call to iio_push_to_buffers.
>=20
> >=20
> >=20
> > Also, how do I identify my particular 3d sensor? Or it is the same
> > model
> > everywhere? Or it is the driver for all of them?
>=20
> Lots an lots and lots of drivers ;)   But in laptops they are often
> hid-sensors, or at least there is a little microcontroller that
> handles
> the different streams and reformats them as hid sensor records.
>=20
> >=20
> > Here is dmesg | grep i2c:
>=20
> First of all, let us check the device. I'm going to guess it's a hid
> sensor of some type.
> Could you cat
> /sys/bus/iio/devices/iio\:device0/name
>=20
> When iio-sensor-proxy is running (or after you've killed it) check
> what the values in the various files in
> /sys/bus/iio/devices/iio\:device0/scan_elements/*=20
> are.  One thought is we have some unexpected channels enabled and
> the code is thinking they are acceleration when they aren't.
>=20
> >=20
> > [root@aikyoga iio:device4]# dmesg | egrep '(i2c|iio)'
> > [    5.389867] i2c_hid i2c-ITE8350:00: i2c-ITE8350:00 supply vdd
> > not
> > found, using dummy regulator
> > [    5.389893] i2c_hid i2c-ITE8350:00: Linked as a consumer to
> > regulator.0
> > [    5.389896] i2c_hid i2c-ITE8350:00: i2c-ITE8350:00 supply vddl
> > not
> > found, using dummy regulator
> > [    5.502896] hid-generic 0018:048D:8350.0002: hidraw1: I2C HID
> > v1.00
> > Device [ITE8350:00 048D:8350] on i2c-ITE8350:00
> > [    5.528455] i2c_hid i2c-SYNA2B23:00: i2c-SYNA2B23:00 supply vdd
> > not
> > found, using dummy regulator
> > [    5.528485] i2c_hid i2c-SYNA2B23:00: Linked as a consumer to
> > regulator.0
> > [    5.528489] i2c_hid i2c-SYNA2B23:00: i2c-SYNA2B23:00 supply vddl
> > not
> > found, using dummy regulator
> > [    5.543440] input: SYNA2B23:00 06CB:2714 Mouse as
> > /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-6/i2c-
> > SYNA2B23:00/0018:06CB:2714.0003/input/input13
> > [    5.543690] hid-generic 0018:06CB:2714.0003: input,hidraw2: I2C
> > HID
> > v1.00 Mouse [SYNA2B23:00 06CB:2714] on i2c-SYNA2B23:00
> > [    6.053237] input: Synaptics TM2714-002 as
> > /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-6/i2c-
> > SYNA2B23:00/0018:06CB:2714.0003/input/input16
> > [    6.053444] hid-rmi 0018:06CB:2714.0003: input,hidraw1: I2C HID
> > v1.00
> > Mouse [SYNA2B23:00 06CB:2714] on i2c-SYNA2B23:00
> >=20
> > Thanks!
> >=20
> >=20
>=20
>=20

--=-UWoft9krd6T/kOhI/qF2
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
n4IJlKBiiK7B8oFPhD7KEZOWboHrE2uHLEkIXpp852sG0oFkLLstEDK9Z46WS4Ni1yfGRE6jY79A
DJOEZIX9AgMBAAGjggI9MIICOTAdBgNVHQ4EFgQUZ2w0kbL1uZEoQTmAiMqoAXL81L8wHwYDVR0j
BBgwFoAU2kEjnFqPca9Xgz4g0+Nl2wzLC9swZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5p
bnRlbC5jb20vcmVwb3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWlu
ZyUyMENBJTIwNEIuY3JsMIGfBggrBgEFBQcBAQSBkjCBjzAiBggrBgEFBQcwAYYWaHR0cDovL29j
c3AuaW50ZWwuY29tLzBpBggrBgEFBQcwAoZdaHR0cDovL3d3dy5pbnRlbC5jb20vcmVwb3NpdG9y
eS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENBJTIw
NEIuY3J0MAsGA1UdDwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9
gSiFjp9TgpHACWeB3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMM
MCkGCSsGAQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBXBgNVHREEUDBOoC0G
CisGAQQBgjcUAgOgHwwdc3Jpbml2YXMucGFuZHJ1dmFkYUBpbnRlbC5jb22BHXNyaW5pdmFzLnBh
bmRydXZhZGFAaW50ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQAXirNmyawI/PJRnjPoqNcgSr8N
8VXBvv8kwQidSNWKswBqo8ul8u+pkG7v8YjZUy1OJQUFXPvihht10Tb5O2xZ9hpIo4WFcRX2eg2Z
t6koRJUB9ZDjEETG2j4EpcGmWIBrDBNZLZTLIYG5JzsS6mGCq42AKspSAJD00vwfL0KlCc4BVUvC
64+q7etbf6c90n05KjfLfoUXBqwWLJCe3KPD20d/kbvesTzs2PVQxI7K1eL9n2rBoqBpcRY0ppkz
FKjiTQ8IcwhyWQbzLfVIy5tNuyinhNBRv3COOMGoayaljijEPcEHLE63tA2OIao2Hz6GLRYzg0mT
hCtsB4xSboPZMYICFzCCAhMCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYD
VQQHEwtTYW50YSBDbGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIklu
dGVsIEV4dGVybmFsIEJhc2ljIElzc3VpbmcgQ0EgNEICEzMAAGknngjvas7THxUAAAAAaScwCQYF
Kw4DAhoFAKBdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDMx
NzE2MzkxN1owIwYJKoZIhvcNAQkEMRYEFBWJkwb47tVl38EBggtClwpG+8z7MA0GCSqGSIb3DQEB
AQUABIIBALEazcJjkjggw6YlHV1omu80Bh1rOeRWSYqyNbFhwQmeXaPjVr4GTsHRY6/w5R3nWA2O
85OKCuIpbX4fvixjJ/qSOu57Kuv+NMeIs8pduawB+4+Mi21FhD1iku2AQz2reZfuX/0EM6Ve1fNa
b4wrtR5V2Sy/ktM56JaIfygmZCnH/TGRnm3QjcQldfLriYEj+9OVod2z1vOHOWk/3EThhRVtpCny
X1Si4jh9qmRLVapRSTgu8ZfE1gkkzC1an4ecu1hBLFD1gwxesMhSSOQ4jnIrky7UVSZoEtmhRc09
7rSK341bCeJHmhDMAjO9z4vInG9zkURlXe1/oZERVvqp+ngAAAAAAAA=


--=-UWoft9krd6T/kOhI/qF2--
