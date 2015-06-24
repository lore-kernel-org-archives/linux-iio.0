Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:47159 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbbFXPUE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 24 Jun 2015 11:20:04 -0400
Message-ID: <d36d734164c9679d55d630893ace65a4.squirrel@mungewell.org>
In-Reply-To: <20150624111343.9cbff925b0f25865fc6e5cd8@ao2.it>
References: <1435105830-2297-1-git-send-email-simon@mungewell.org>
    <1435105830-2297-2-git-send-email-simon@mungewell.org>
    <20150624111343.9cbff925b0f25865fc6e5cd8@ao2.it>
Date: Wed, 24 Jun 2015 11:20:03 -0400
Subject: Re: [RFC_v2 1/4] HID: hid-sony: Add basic IIO support for SixAxis
 Controller
From: simon@mungewell.org
To: "Antonio Ospite" <ao2@ao2.it>
Cc: "Simon Wood" <simon@mungewell.org>, linux-input@vger.kernel.org,
	"Frank Praznik" <frank.praznik@oh.rr.com>,
	linux-iio@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


>> +	case IIO_CHAN_INFO_SCALE:
>> +		switch (chan->type) {
>> +		case IIO_ACCEL:
>> +			*val = 0;	/* 9.80665/117 = 0.084540086 */
>> +			*val2 = 84540;
>
> I guess 9.80665 is 'g', but is the 117 taken from the accelerometer
> datasheet? What is it? And BTW I get 9.80665/117 = 0.083817521

The '117' was taken from experimentation, average value accessed across
all accelerometer axis on a stationary device.

It does appear however that I can not use a calculator ;-) (...must have
been a prior value left there).
Simon.

