Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E993191D0;
	Tue,  3 Feb 2026 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770115440; cv=none; b=p5D+n4XqRtdhYH531JWwTpxKowX/0Xz1lcyNeFo3FZPl3pQzwgiimoWHv/2DKGVWB6s4xKSBsK25C+CeAndqkpaI3eHXxwqrujkc31oxl6VWkF4GTe7ciatWsjLIOAs15uFaiNVBnLDVHmBjm6+2QoZYEriUlmDwlk6b1R5AJaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770115440; c=relaxed/simple;
	bh=1XQ8BAZIGYI7qNIB0JZ4X3HetJd+LN/QgAz33SD9ERU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mINz+UN4jU3z4/EEbaTXR94Y/DXGv7HNPNiQuxoYtpCXiF78zWbyEDwtJkz1xvdoxincL5LaBhq9+59zHg5J2E7NKFCGHq3uDD11svgfTB7DbF093zEQDisqZOWyE3bhiSHG7gVke9QI+9MO6C40GABo9pIehT8sjYZIQs6zn8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=vozIREGh; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="vozIREGh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770115435; x=1770720235; i=spasswolf@web.de;
	bh=y6PXQ9S+CYNmbxf9mRz2NlkK/o6rAz2vA60jmxUr7Ms=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vozIREGhtKS1HzDFLXga43MjjxEfESHNen8p2+EpZfw52o3OYkAV9APa2PhU6kRn
	 Qsq0bqxEZPgMqQGVDBIJslKEWzvW5+nk26zsbtUgT6ynZQLYPafQRGCrwX7CpZxE8
	 HKZO0K2R18QE1bh83lO3kZ19a1aOh6mirCNvRV34/vHHnV9JACKpK5Gn01JsxrKdZ
	 zuHhe0dQlg4tlbrrvPk4VJrLVa81Ev4ynJ8YYxcpPn4I6SHBdQSE9HBEbneO9NBgT
	 ffKyEdgN2Rsq9b0D+YF+uqLniVN/0FzYQGfPiE0UnZoJexP6W2R801+NokUeih02X
	 ON+/4nKnMJx/sajShw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLARS-1w5Iy11EGo-00LYgH; Tue, 03
 Feb 2026 11:43:55 +0100
Message-ID: <476cf5e072259332676c431c19ca3188705a86f1.camel@web.de>
Subject: Re: [tip: irq/core] genirq: Warn about using IRQF_ONESHOT without a
 threaded handler
From: Bert Karwatzki <spasswolf@web.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Jiri Kosina	
 <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Srinivas
 Pandruvada	 <srinivas.pandruvada@linux.intel.com>, Thomas Gleixner
 <tglx@kernel.org>,  Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 spasswolf@web.de
Date: Tue, 03 Feb 2026 11:43:53 +0100
In-Reply-To: <20260203083826.1gOzxrwt@linutronix.de>
References: <20260113120541.YVf2vRA3@linutronix.de>
	 <20260202232741.13380-1-spasswolf@web.de>
	 <20260203083826.1gOzxrwt@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uTXnoyFCMopwXm5/Juwuv5FScP6pccwBFvHhqXZ9V9p62xiIeBg
 JD1zrac7041JLsC8Oj1vJKnxl+9/+nE07GKda0C8HKjmVBdSvUN78g5+61HFcr7vKSlZPJA
 w1NoG7biJWlmeA7IQ904k9T08DPOQzFXtzC1QQWc1a6H/u1fvt84PpU5B6kGLQAvjjMpoVi
 jduKc3RE2fpXmhNjrdqeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nHAPKahaZ2Y=;nAaAlYLyI0pEbU5/w/oMVoSmXdk
 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

Am Dienstag, dem 03.02.2026 um 09:38 +0100 schrieb Sebastian Andrzej Siewi=
or:
> On 2026-02-03 00:27:40 [+0100], Bert Karwatzki wrote:
> >=20
> > The warning appears because iio_triggered_buffer_setup_ext() (in=20
> > drivers/iio/buffer/industrialio-triggered-buffer.c) is called with thr=
ead =3D NULL
> > during the probe of the iio device and calls iio_alloc_pollfunc()
> > (in drivers/iio/industrialio-trigger.c) with thread =3D NULL and type =
=3D IRQF_ONESHOT.
> >=20
> > A simple fix could be this:
> >=20
> > diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/driv=
ers/iio/buffer/industrialio-triggered-buffer.c
> > index 9bf75dee7ff8..40eea3a44724 100644
> > --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
> > +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
> > @@ -64,7 +64,7 @@ int iio_triggered_buffer_setup_ext(struct iio_dev *i=
ndio_dev,
> > =20
> >         indio_dev->pollfunc =3D iio_alloc_pollfunc(h,
> >                                                  thread,
> > -                                                IRQF_ONESHOT,
> > +                                                thread ? IRQF_ONESHOT=
 : 0,
> >                                                  indio_dev,
> >                                                  "%s_consumer%d",
> >                                                  indio_dev->name,
> >=20
> >=20
> > Are there any problems with this?
>=20
> Urgh. Haven't seen those.
>=20
> Looking at all the users of of *iio_triggered_buffer_setup*() the
> primary handler is either NULL or iio_pollfunc_store_time().=20
> So IRQF_ONESHOST should work all the time.
>=20
> Then there is=20
> - drivers/iio/adc/vf610_adc.c=20
> - drivers/iio/common/hid-sensors/hid-sensor-trigger.c
>=20
> They use iio_pollfunc_store_time() as primary and have no secondary.
> This would trigger the warning but not having a secondary handler while
> returning IRQF_WAKE_THREAD should create a warning of its own.

Yes, this should call warn_no_thread() when the interrupt is triggered, bu=
t
I don't know if these sensors are actually functional on my laptop (I've n=
ever
tried to use them).

So I installed libiio-utils from debian and this is the output from
iio_info:


# iio_info=20
iio_info version: 0.26 (git tag:v0.26)
Libiio version: 0.26 (git tag: v0.26) backends: local xml ip usb serial
IIO context created with local backend.
Backend version: 0.26 (git tag: v0.26)
Backend description string: Linux lisa 6.19.0-rc7-next-20260130-iiofix-000=
01-gc30f943f5645 #293 SMP PREEMPT_DYNAMIC Tue Feb  3 00:32:20 CET 2026 x86=
_64
IIO context has 2 attributes:
	local,kernel: 6.19.0-rc7-next-20260130-iiofix-00001-gc30f943f5645
	uri: local:
IIO context has 21 devices:
	hwmon0: acpitz
		1 channels found:
			temp1:  (input)
			1 channel-specific attributes found:
				attr  0: input value: 59000
		No trigger on this device
	hwmon1: nvme
		2 channels found:
			temp3:  (input)
			2 channel-specific attributes found:
				attr  0: input value: 77850
				attr  1: label value: Sensor 2
			temp1:  (input)
			6 channel-specific attributes found:
				attr  0: alarm value: 0
				attr  1: crit value: 88850
				attr  2: input value: 29850
				attr  3: label value: Composite
				attr  4: max value: 83850
				attr  5: min value: -20150
		No trigger on this device
	hwmon2: nvme
		4 channels found:
			temp2:  (input)
			4 channel-specific attributes found:
				attr  0: input value: 32850
				attr  1: label value: Sensor 1
				attr  2: max value: 65261850
				attr  3: min value: -273150
			temp6:  (input)
			4 channel-specific attributes found:
				attr  0: input value: 35850
				attr  1: label value: Sensor 5
				attr  2: max value: 65261850
				attr  3: min value: -273150
			temp3:  (input)
			4 channel-specific attributes found:
				attr  0: input value: 30850
				attr  1: label value: Sensor 2
				attr  2: max value: 65261850
				attr  3: min value: -273150
			temp1:  (input)
			6 channel-specific attributes found:
				attr  0: alarm value: 0
				attr  1: crit value: 79850
				attr  2: input value: 31850
				attr  3: label value: Composite
				attr  4: max value: 69850
				attr  5: min value: -273150
		No trigger on this device
	hwmon3: amdgpu
		7 channels found:
			temp3:  (input)
			5 channel-specific attributes found:
				attr  0: crit value: 100000
				attr  1: crit_hyst value: -273150
				attr  2: emergency value: 105000
				attr  3: input value: 46000
				attr  4: label value: mem
			temp2:  (input)
			5 channel-specific attributes found:
				attr  0: crit value: 100000
				attr  1: crit_hyst value: -273150
				attr  2: emergency value: 105000
				attr  3: input value: 46000
				attr  4: label value: junction
			in0:  (input)
			2 channel-specific attributes found:
				attr  0: input value: 6
				attr  1: label value: vddgfx
			power1:  (input)
			6 channel-specific attributes found:
				attr  0: average value: 4000000
				attr  1: cap value: 65000000
				attr  2: cap_default value: 65000000
				attr  3: cap_max value: 65000000
				attr  4: cap_min value: 65000000
				attr  5: label value: PPT
			fan1:  (input)
			5 channel-specific attributes found:
				attr  0: enable value: 0
				attr  1: input value: 0
				attr  2: max value: 3300
				attr  3: min value: 0
				attr  4: target value: 0
			temp1:  (input)
			5 channel-specific attributes found:
				attr  0: crit value: 100000
				attr  1: crit_hyst value: -273150
				attr  2: emergency value: 105000
				attr  3: input value: 46000
				attr  4: label value: edge
			pwm1:  (input)
			4 channel-specific attributes found:
				attr  0: enable value: 2
				attr  1: max value: 255
				attr  2: min value: 0
				attr  3: pwm1 value: 91
		4 device-specific attributes found:
				attr  0: freq1_input value: 0
				attr  1: freq1_label value: sclk
				attr  2: freq2_input value: 96000000
				attr  3: freq2_label value: mclk
		No trigger on this device
	hwmon4: amdgpu
		4 channels found:
			in1:  (input)
			2 channel-specific attributes found:
				attr  0: input value: 962
				attr  1: label value: vddnb
			in0:  (input)
			2 channel-specific attributes found:
				attr  0: input value: 1099
				attr  1: label value: vddgfx
			power1:  (input)
			2 channel-specific attributes found:
				attr  0: input value: 17000000
				attr  1: label value: PPT
			temp1:  (input)
			2 channel-specific attributes found:
				attr  0: input value: 49000
				attr  1: label value: edge
		2 device-specific attributes found:
				attr  0: freq1_input value: 400000000
				attr  1: freq1_label value: sclk
		No trigger on this device
	hwmon5: ADP1
		0 channels found:
		No trigger on this device
	hwmon6: k10temp
		1 channels found:
			temp1:  (input)
			2 channel-specific attributes found:
				attr  0: input value: 56500
				attr  1: label value: Tctl
		No trigger on this device
	hwmon7: BAT1
		2 channels found:
			in0:  (input)
			1 channel-specific attributes found:
				attr  0: input value: 15801
			curr1:  (input)
			1 channel-specific attributes found:
				attr  0: input value: 0
		No trigger on this device
	hwmon8: mt7921_phy0
		1 channels found:
			temp1:  (input)
			1 channel-specific attributes found:
				attr  0: input value: 42000
		No trigger on this device
	iio:device0: als (buffer capable)
		6 channels found:
			intensity_both:  (input, index: 0, format: le:S32/32>>0)
			6 channel-specific attributes found:
				attr  0: hysteresis ERROR: Invalid argument (22)
				attr  1: hysteresis_relative value: 0.000000
				attr  2: offset value: 0
				attr  3: raw value: 0
				attr  4: sampling_frequency value: 10.000000
				attr  5: scale value: 0.100000000
			illuminance:  (input, index: 1, format: le:S32/32>>0)
			6 channel-specific attributes found:
				attr  0: hysteresis ERROR: Invalid argument (22)
				attr  1: hysteresis_relative value: 0.000000
				attr  2: offset value: 0
				attr  3: raw value: 0
				attr  4: sampling_frequency value: 10.000000
				attr  5: scale value: 0.100000000
			colortemp:  (input, WARN:iio_channel_get_type()=3DUNKNOWN, index: 2, fo=
rmat: le:S32/32>>0)
			6 channel-specific attributes found:
				attr  0: hysteresis ERROR: Invalid argument (22)
				attr  1: hysteresis_relative value: 0.000000
				attr  2: offset value: 0
				attr  3: raw value: -16843009
				attr  4: sampling_frequency value: 10.000000
				attr  5: scale value: 0.100000000
			chromaticity_x:  (input, WARN:iio_channel_get_type()=3DUNKNOWN, index: =
3, format: le:S32/32>>0)
			6 channel-specific attributes found:
				attr  0: hysteresis ERROR: Invalid argument (22)
				attr  1: hysteresis_relative value: 0.000000
				attr  2: offset value: 0
				attr  3: raw value: -1073087296
				attr  4: sampling_frequency value: 10.000000
				attr  5: scale value: 0.100000000
			chromaticity_y:  (input, WARN:iio_channel_get_type()=3DUNKNOWN, index: =
4, format: le:S32/32>>0)
			6 channel-specific attributes found:
				attr  0: hysteresis ERROR: Invalid argument (22)
				attr  1: hysteresis_relative value: 0.000000
				attr  2: offset value: 0
				attr  3: raw value: 0
				attr  4: sampling_frequency value: 10.000000
				attr  5: scale value: 0.100000000
			timestamp:  (input, index: 5, format: le:S64/64>>0)
		1 device-specific attributes found:
				attr  0: current_timestamp_clock value: realtime
		2 buffer-specific attributes found:
				attr  0: data_available value: 0
				attr  1: direction value: in
		Current trigger: trigger0(als-dev0)
	iio:device1: als (buffer capable)
		6 channels found:
			intensity_both:  (input, index: 0, format: le:S32/32>>0)
			6 channel-specific attributes found:
				attr  0: hysteresis ERROR: Invalid argument (22)
				attr  1: hysteresis_relative value: 0.000000
				attr  2: offset value: 0
				attr  3: raw value: 0
				attr  4: sampling_frequency value: 0.000000
				attr  5: scale value: 0.100000000
			illuminance:  (input, index: 1, format: le:S32/32>>0)
			6 channel-specific attributes found:
				attr  0: hysteresis ERROR: Invalid argument (22)
				attr  1: hysteresis_relative value: 0.000000
				attr  2: offset value: 0
				attr  3: raw value: 0
				attr  4: sampling_frequency value: 0.000000
				attr  5: scale value: 0.100000000
			colortemp:  (input, WARN:iio_channel_get_type()=3DUNKNOWN, index: 2, fo=
rmat: le:S32/32>>0)
			6 channel-specific attributes found:
				attr  0: hysteresis ERROR: Invalid argument (22)
				attr  1: hysteresis_relative value: 0.000000
				attr  2: offset value: 0
				attr  3: raw value: 0
				attr  4: sampling_frequency value: 0.000000
				attr  5: scale value: 0.100000000
			chromaticity_x:  (input, WARN:iio_channel_get_type()=3DUNKNOWN, index: =
3, format: le:S32/32>>0)
			6 channel-specific attributes found:
				attr  0: hysteresis ERROR: Invalid argument (22)
				attr  1: hysteresis_relative value: 0.000000
				attr  2: offset value: 0
				attr  3: raw value: 0
				attr  4: sampling_frequency value: 0.000000
				attr  5: scale value: 0.100000000
			chromaticity_y:  (input, WARN:iio_channel_get_type()=3DUNKNOWN, index: =
4, format: le:S32/32>>0)
			6 channel-specific attributes found:
				attr  0: hysteresis ERROR: Invalid argument (22)
				attr  1: hysteresis_relative value: 0.000000
				attr  2: offset value: 0
				attr  3: raw value: 0
				attr  4: sampling_frequency value: 0.000000
				attr  5: scale value: 0.100000000
			timestamp:  (input, index: 5, format: le:S64/64>>0)
		1 device-specific attributes found:
				attr  0: current_timestamp_clock value: realtime
		2 buffer-specific attributes found:
				attr  0: data_available value: 0
				attr  1: direction value: in
		Current trigger: trigger1(als-dev1)
	iio:device2: gyro_3d (buffer capable)
		4 channels found:
			anglvel_x:  (input, index: 0, format: le:S32/32>>0)
			5 channel-specific attributes found:
				attr  0: hysteresis value: 0.000000
				attr  1: offset value: 0
				attr  2: raw value: 0
				attr  3: sampling_frequency value: 0.000000
				attr  4: scale value: 0.000174532
			anglvel_y:  (input, index: 1, format: le:S32/32>>0)
			5 channel-specific attributes found:
				attr  0: hysteresis value: 0.000000
				attr  1: offset value: 0
				attr  2: raw value: 0
				attr  3: sampling_frequency value: 0.000000
				attr  4: scale value: 0.000174532
			anglvel_z:  (input, index: 2, format: le:S32/32>>0)
			5 channel-specific attributes found:
				attr  0: hysteresis value: 0.000000
				attr  1: offset value: 0
				attr  2: raw value: 0
				attr  3: sampling_frequency value: 0.000000
				attr  4: scale value: 0.000174532
			timestamp:  (input, index: 3, format: le:S64/64>>0)
		1 device-specific attributes found:
				attr  0: current_timestamp_clock value: realtime
		2 buffer-specific attributes found:
				attr  0: data_available value: 0
				attr  1: direction value: in
		Current trigger: trigger2(gyro_3d-dev2)
	iio:device3: prox (buffer capable)
		1 channels found:
			proximity0:  (input, index: 0, format: le:s8/32>>0)
			5 channel-specific attributes found:
				attr  0: hysteresis ERROR: Invalid argument (22)
				attr  1: offset value: 0
				attr  2: raw value: 15
				attr  3: sampling_frequency value: 10.000000
				attr  4: scale value: 1.000000000
		2 buffer-specific attributes found:
				attr  0: data_available value: 0
				attr  1: direction value: in
		Current trigger: trigger4(prox-dev3)
	iio:device4: accel_3d (buffer capable)
		4 channels found:
			accel_x:  (input, index: 0, format: le:S32/32>>0)
			5 channel-specific attributes found:
				attr  0: hysteresis value: 0.000000
				attr  1: offset value: 0
				attr  2: raw value: 0
				attr  3: sampling_frequency value: 10.000000
				attr  4: scale value: 0.098066500
			accel_y:  (input, index: 1, format: le:S32/32>>0)
			5 channel-specific attributes found:
				attr  0: hysteresis value: 0.000000
				attr  1: offset value: 0
				attr  2: raw value: 0
				attr  3: sampling_frequency value: 10.000000
				attr  4: scale value: 0.098066500
			accel_z:  (input, index: 2, format: le:S32/32>>0)
			5 channel-specific attributes found:
				attr  0: hysteresis value: 0.000000
				attr  1: offset value: 0
				attr  2: raw value: 0
				attr  3: sampling_frequency value: 10.000000
				attr  4: scale value: 0.098066500
			timestamp:  (input, index: 3, format: le:S64/64>>0)
		1 device-specific attributes found:
				attr  0: current_timestamp_clock value: realtime
		2 buffer-specific attributes found:
				attr  0: data_available value: 0
				attr  1: direction value: in
		Current trigger: trigger3(accel_3d-dev4)
	iio:device5: magn_3d (buffer capable)
		3 channels found:
			magn_x:  (input, index: 0, format: le:S32/32>>0)
			5 channel-specific attributes found:
				attr  0: hysteresis value: 0.000000
				attr  1: offset value: 0
				attr  2: raw value: 0
				attr  3: sampling_frequency value: 0.000000
				attr  4: scale value: 0.000001000
			magn_y:  (input, index: 1, format: le:S32/32>>0)
			5 channel-specific attributes found:
				attr  0: hysteresis value: 0.000000
				attr  1: offset value: 0
				attr  2: raw value: 0
				attr  3: sampling_frequency value: 0.000000
				attr  4: scale value: 0.000001000
			magn_z:  (input, index: 2, format: le:S32/32>>0)
			5 channel-specific attributes found:
				attr  0: hysteresis value: 0.000000
				attr  1: offset value: 0
				attr  2: raw value: 0
				attr  3: sampling_frequency value: 0.000000
				attr  4: scale value: 0.000001000
		2 buffer-specific attributes found:
				attr  0: data_available value: 0
				attr  1: direction value: in
		Current trigger: trigger5(magn_3d-dev5)
	trigger0: als-dev0
		0 channels found:
		No trigger on this device
	trigger1: als-dev1
		0 channels found:
		No trigger on this device
	trigger2: gyro_3d-dev2
		0 channels found:
		No trigger on this device
	trigger3: accel_3d-dev4
		0 channels found:
		No trigger on this device
	trigger4: prox-dev3
		0 channels found:
		No trigger on this device
	trigger5: magn_3d-dev5
		0 channels found:
		No trigger on this device

The iio:device* sensors all report 0 for the "offset value", so these
sensors are maybe non-fuctional.


> What did I miss?

I don't think you missed something, but the thread function being NULL her=
e
could a problem on devices where these sensors actually work. (Or perhaps =
these sensors
need to be polled and the interrupts never trigger (?))

Bert Karwatzki
>=20
