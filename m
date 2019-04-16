Return-Path: <SRS0=o58m=SS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89548C10F0E
	for <linux-iio@archiver.kernel.org>; Tue, 16 Apr 2019 01:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DD220818
	for <linux-iio@archiver.kernel.org>; Tue, 16 Apr 2019 01:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfDPB3a (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 15 Apr 2019 21:29:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:51989 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbfDPB3a (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 15 Apr 2019 21:29:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 18:29:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,355,1549958400"; 
   d="p7s'?scan'208";a="162230385"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga004.fm.intel.com with ESMTP; 15 Apr 2019 18:29:29 -0700
Received: from orsmsx163.amr.corp.intel.com (10.22.240.88) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 15 Apr 2019 18:29:28 -0700
Received: from orsmsx109.amr.corp.intel.com ([169.254.11.52]) by
 ORSMSX163.amr.corp.intel.com ([169.254.9.163]) with mapi id 14.03.0415.000;
 Mon, 15 Apr 2019 18:29:28 -0700
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "Song, Hongyan" <hongyan.song@intel.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "jikos@kernel.org" <jikos@kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] drivers: iio: Add more data field for iio driver
 hysteresis parsing
Thread-Topic: [PATCH] drivers: iio: Add more data field for iio driver
 hysteresis parsing
Thread-Index: AQHU7nIwleYiOdt1pUS6nEYUQUpzvaY8FcGAgAJqWoA=
Date:   Tue, 16 Apr 2019 01:29:28 +0000
Message-ID: <d5085421bb3305d896930192b99c5bf84260e5c1.camel@intel.com>
References: <1554773465-21882-1-git-send-email-hongyan.song@intel.com>
         <20190414133615.56be4eb1@archlinux>
In-Reply-To: <20190414133615.56be4eb1@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.156.198]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-ReHw335o2tF+dYNzZ4V2"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--=-ReHw335o2tF+dYNzZ4V2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2019-04-14 at 13:36 +0100, Jonathan Cameron wrote:
> On Tue,  9 Apr 2019 09:31:04 +0800
> hongyan.song@intel.com wrote:
>=20
> > From: Song Hongyan <hongyan.song@intel.com>
> >=20
> > Add more data field support for als, incli_3d, rotation, press
> > hysteresis parsing. In some implementation may uses them as
> > sensitivity
> > modifier, without this change hysteresis may not be able to read
> > and
> > write.
> >=20
> > Signed-off-by: Song Hongyan <hongyan.song@intel.com>
>=20
> Thanks for the patch. I'll be honest I'm lost in these descriptors
> sometimes!
>=20
> Srinivas, could you give some input on this one?
I don't see we have defined hysteresis attribute in
"Documentation/ABI/testing/sysfs-bus-iio" for non events.
The current hysteresis is taken a absolute raw value in relation to the
other axes in the same unit.

But it is better if we add different hysteresis attributes for non
absolute hysteresis.

For example
in_xxx_hysteresis_pct_range for "Modifier: Change Sensitivity Percent
of Range" usage id: 310
in_xxx_hysteresis_pct_relative for "Modifier: Change Sensitivity
Percent Relative" usage id: 311


Thanks,
Srinivas



>=20
> I will note however, that from a quick look we tend to air these
> queries with dev_dbg entries.  We should be consistent with these new
> ones
> as well.attaributes
>=20
> Thanks,
>=20
> Jonathan
> > ---
> >  drivers/iio/light/hid-sensor-als.c            | 8 ++++++++
> >  drivers/iio/orientation/hid-sensor-incl-3d.c  | 8 ++++++++
> >  drivers/iio/orientation/hid-sensor-rotation.c | 7 +++++++
> >  drivers/iio/pressure/hid-sensor-press.c       | 8 ++++++++
> >  include/linux/hid-sensor-ids.h                | 1 +
> >  5 files changed, 32 insertions(+)attaributes
> >=20
> > diff --git a/drivers/iio/light/hid-sensor-als.c
> > b/drivers/iio/light/hid-sensor-als.c
> > index 94f3325..bb19178 100644
> > --- a/drivers/iio/light/hid-sensor-als.c
> > +++ b/drivers/iio/light/hid-sensor-als.c
> > @@ -271,6 +271,14 @@ static int als_parse_report(struct
> > platform_device *pdev,
> >  			st->common_attributes.sensitivity.index,
> >  			st->common_attributes.sensitivity.report_id);
> >  	}
> > +	if (st->common_attributes.sensitivity.index < 0) {
> > +		sensor_hub_input_get_attribute_info(hsdev,
> > +			HID_FEATURE_REPORT, usage_id,
> > +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_RE
> > L_PCT |
> > +			HID_USAGE_SENSOR_LIGHT_ILLUM,
> > +			&st->common_attributes.sensitivity);
> > +	}
> > +
> >  	return ret;
> >  }
> > =20
> > diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c
> > b/drivers/iio/orientation/hid-sensor-incl-3d.c
> > index bdc5e45..7da1e3f 100644
> > --- a/drivers/iio/orientation/hid-sensor-incl-3d.c
> > +++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
> > @@ -305,6 +305,14 @@ static int incl_3d_parse_report(struct
> > platform_device *pdev,
> >  			st->commpcton_attributes.sensitivity.index,
> >  			st->common_attributes.sensitivity.report_id);
> >  	}
> > +	if (st->common_attributes.sensitivity.index < 0) {
> > +		sensor_hub_input_get_attribute_info(hsdev,
> > +			HID_FEATURE_REPORT, usage_id,
> > +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_AB
> > S |
> > +			HID_USAGE_SENSOR_ORIENT_TILT,
> > +			&st->common_attributes.sensitivity);
> > +	}
> > +
> >  	return ret;
> >  }
> > =20
> > diff --git a/drivers/iio/orientation/hid-sensor-rotation.c
> > b/drivers/iio/orientation/hid-sensor-rotation.c
> > index a69db20..201e320 100644
> > --- a/drivers/iio/orientation/hid-sensor-rotation.c
> > +++ b/drivers/iio/orientation/hid-sensor-rotation.c
> > @@ -229,6 +229,13 @@ static int dev_rot_parse_report(struct
> > platform_device *pdev,
> >  			st->common_attributes.sensitivity.index,
> >  			st->common_attributes.sensitivity.report_id);
> >  	}
> > +	if (st->common_attributes.sensitivity.index < 0) {
> > +		sensor_hub_input_get_attribute_info(hsdev,
> > +			HID_FEATURE_REPORT, usage_id,
> > +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_AB
> > S |
> > +			HID_USAGE_SENSOR_ORIENT_QUATERNION,
> > +			&st->common_attributes.sensitivity);
> > +	}
> > =20
> >  	return 0;
> >  }
> > diff --git a/drivers/iio/pressure/hid-sensor-press.c
> > b/drivers/iio/pressure/hid-sensor-press.c
> > index d7b1c00..bf5d2ac 10064pct4
> > --- a/drivers/iio/pressure/hid-sensor-press.c
> > +++ b/drivers/iio/pressure/hid-sensor-press.c
> > @@ -250,6 +250,14 @@ static int press_parse_report(struct
> > platform_device *pdev,
> >  			st->common_attributes.sensitivity.index,
> >  			st->common_attributes.sensitivity.report_id);
> >  	}
> > +	if (st->common_attributes.sensitivity.index < 0) {
> > +		sensor_hub_input_get_attribute_info(hsdev,
> > +			HID_FEATURE_REPORT, usage_id,
> > +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_AB
> > S |
> > +			HID_USAGE_SENSOR_ATMOSPHERIC_PRESSURE,
> > +			&st->common_attributes.sensitivity);
> > +	}
> > +
> >  	return ret;
> >  }
> > =20
> > diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-
> > sensor-ids.h
> > index 76033e0..a875b9be 100644
> > --- a/include/linux/hid-sensor-ids.h
> > +++ b/include/linux/hid-sensor-ids.h
> > @@ -158,6 +158,7 @@
> >  /* Per data field properties */
> >  #define HID_USAGE_SENSOR_DATA_MOD_NONE			=09
> > 	0x00
> >  #define HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS	=09
> > 0x1000
> > +#define
> > HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_REL_PCT            0xE
> > 000
> > =20
> >  /* Power state enumerations */
> >  #define HID_USAGE_SENSOR_PROP_POWER_STATE_UNDEFINED_ENUM	0x20085
> > 0
>=20
>=20

--=-ReHw335o2tF+dYNzZ4V2
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
Kw4DAhoFAKBdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDQx
NjAxMjkyNVowIwYJKoZIhvcNAQkEMRYEFDjtb72d+wJi4Q5R/SPZ4snD/pOrMA0GCSqGSIb3DQEB
AQUABIIBAIcNCHddnp7Q8ptXjqlsinpkaltxe5Xfie/sSFl4BJX3EkAl7yZWCZQtZYQOcpIH/qix
V64rmkMarT2FfxT/c0SScELoq4s0two33KkEbV+crW6wpuTO91ka5DHw3VxnEUF7cGODeKzs3pGv
ONUPMDQgg9hJKgqqBmWnWV1cHX03WXbfXo5NiFnejX6DE7D4vcL9EsI6kNz7oHpTfYP0sdF3sPHJ
owmuI71wguJi18/sH9/ei38W+K4KNB7MkQW0BYDCNe+ErL0YJDgaLTNrcpPHISRW3HIS9Prsrku0
IrdrIO6e+GdUUpPW6x/YZAKcSsJecpAVrpg4HPuLP0/GmZQAAAAAAAA=


--=-ReHw335o2tF+dYNzZ4V2--
