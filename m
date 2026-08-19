Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B63CF046
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 18:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787164749; cv=none; b=sofc7upA7a5yRE0dyt+ib15avdCNyIYhypAdn6QGLKD9lVkSra6etJEJV1QR1CCWzf9l2lxrii7XKBgS4W6MRK3DRu6s3fEGRGK4YODB23HplrZFC7C/wBn10RPeWlNgHwOA78y1jWY5OuM7ds8HbAW5XHy3G5IAlbKXxhzoDa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787164749; c=relaxed/simple;
	bh=S/kAfA5WC+LMKoBS1uFyMnrlO7jW1CV42eabY++XOVg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=V6npXUluWEQ+j5/hlHsmEgQdDnNQA/0L+9ygzfVtjD9jFPKvJsZKgSviui4WBnv24a4xZqPSGwR5W9rcGhCPZJwlIb8K0ABKYEfk1Odq8vgfWXDxdOGXs3eA7/uShD0AVm99QF5ZO/kAVzqRxI/Gyd/Y3OFShe+VYV1AZ8TPjBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaZTwrCp; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaZTwrCp"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47f96c5b722so793829f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 11:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787164746; x=1787769546; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WPgYwoDyqTp6QfKS6LN6UFIeQkwI9JmbGZkTQLSD5JE=;
        b=IaZTwrCpAUO/E29pna4j2Kc+PwqKGAU+IP6pXC1/wLJVG0L5qubstX9M/ovNviSjvb
         eHC2eN98SZD23EUXGWxkL6orNBi7fruIXh5qQ/Aap5Qru41OHC3vj+1eJMTTT3yoeCAm
         3okWfosn396RLspk45BIsWYKjKLy7KXl9DAwt0AFc/7KxKXx5EA39g1e07VRrl+xQaRh
         X/2ZJksRSlT/ZIdLlHm1PeGku0OiJhUgZxjFvAInSzlLvi5RBAhl2GdDMNUyKTdjbmbj
         W2DH5lWSDD5i2VeBF4hxOBAKywC17ZWZ83tV/1NE9ZXJzEoVctEK6exTV96vg1uXFTRb
         2RoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787164746; x=1787769546;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WPgYwoDyqTp6QfKS6LN6UFIeQkwI9JmbGZkTQLSD5JE=;
        b=hrTB+Wm2dr7RT0wuKu1FRmL3VAQNDgHy4p1u3LZuw9cL3DnXoySb9T3vBhIq1rcHxE
         V1CilVWI20GafDrgwlfCfzDmFF5YnaF27j97GwmuHChLKAqb26JyX+oydRxOK8tya6vY
         7+qvXvyVx8WPfKob+imVMAGfcG2DWYWTHPuTQk+l7b0hMINRQHR0dFSZgr/9TRUFIuA3
         sruXhdyQqEGFVuyRWK4H1vWqWx1LDn9TZaeVTH83Lq3xp4RFWsnxYgqItO6gP6AhALfy
         F8KJ+dXTlNKi2wmdynmWQypiCaQ0UqY5+7+QWp9y+1ONGiAX/K9lUjTvFy3YwVLVIADC
         JGLw==
X-Forwarded-Encrypted: i=1; AHgh+RrOFZh5AkEzqnmkBARxAJOVdkdtWKlgL9SRoV9roTXJcJQsJNa0EZV3TE6UmsMubwuVvlAPJbNjv2c=@vger.kernel.org
X-Gm-Message-State: AFuF++mjqrIWBvTykaV6L7LlWn+YFnfpo0Eh57qjyKUYQjwuGhvrfvf+
	xVws5wRqL6C+pxR58yLcbiRSDbKDj+us9JA+Z/SGRyZu4e2GOuzJ9i8ZWPtIAg==
X-Gm-Gg: AR+sD12AY+f7VoeVSUH0t/5PtGUBhHU/6nmKQUcxP6PxAvLJvzCfncnSyuPpqJo27RK
	B0PRN4annZy/UzzeEMfE0YulHYeWdqF0VRpV+JJJ3STmWps4w99ODPiaauGRuuoCRxIgCcph60t
	0gP58p5uKef4h3gAhDj9igvoSKa+YLowFXDSlP1m8o4yVVo2sN3URLWApL4eF8DtbOq8AhRAtwb
	FwXScbx5iJIft/5w7crr0czeGVAuFsScpbud8ZI55fCSaPI1nSL48nN+TZHWbj3laqFkxd1Iq/W
	hvkK79LMXIACpDe3S5EXBNeiM1m+rmQPSBomXeTb2Z+6GLIP1HhO5Wmq9A7KoshsfLgY11zBCws
	MyM64ddl/hekKgHIOM2S1mveIaCB3IzC8VNuTcM4VBEmVcrsuzFrQ3A/6H7swnEat0anUKtmrwh
	2dggL0kBanUTU44mBCgnIHF8KFZNU13ybjpTlVOM9Np2hskU60yax9oRMmM+fW8VSFvua7XY4g2
	iI=
X-Received: by 2002:a05:6000:1acc:b0:482:abf6:e3ec with SMTP id ffacd0b85a97d-482b2004955mr9751908f8f.21.1787164745998;
        Wed, 19 Aug 2026 11:39:05 -0700 (PDT)
Received: from localhost ([2001:4bb8:17a:e1ae:eec4:cc25:791c:5824])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b802dsm6340362f8f.17.2026.08.19.11.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 11:39:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 20:39:03 +0200
Message-Id: <DKT510VKO8PN.24FM4NJZ3TWLH@gmail.com>
Subject: Re: [PATCH v7 0/4] iio: light: add support for veml6031x00 ALS
 series
Cc: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Krzysztof
 Kozlowski" <krzk@kernel.org>
To: "Jonathan Cameron" <jic23@kernel.org>, "Andy Shevchenko"
 <andriy.shevchenko@intel.com>
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
X-Mailer: aerc 0.21.0-143-g2f3a2e260c09
References: <20260818-veml6031x00-v7-0-2b0de0f20edf@gmail.com>
 <aoRl-7XIianTyKIB@ashevche-desk.local>
 <20260819020426.1de53bce@jic23-huawei>
In-Reply-To: <20260819020426.1de53bce@jic23-huawei>

On Wed Aug 19, 2026 at 3:04 AM CEST, Jonathan Cameron wrote:
> On Tue, 18 Aug 2026 17:02:35 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>
>> On Tue, Aug 18, 2026 at 01:34:25PM +0200, Javier Carrasco wrote:
>> > These ambient light sensors with I2C interface provide two light
>> > channels (ALS and IR), high/low threshold alarms with configurable
>> > persistence, and a data ready signal.
>> >
>> > The devices covered by this driver have the same resolution, and they
>> > share most of their functionality. These are the differences between
>> > them (note that the x belongs to their names, and it is not a wildcard=
):
>> >
>> >  - Device ID: accessible via two 8-bit registers, different values for
>> >    veml6031x00/veml6031x01 and veml60311x00/veml60311x01.
>> >  - I2C address: same grouping, 0x29 and 0x10 I2C addresses.
>> >  - AEC qualification: AEC-Q100 for veml6031x00/veml60311x00 and
>> >    AEC-Q101 for veml6031x01/veml60311x01.
>> >
>> > The alarms and the data ready signals share the interrupt pin, and an
>> > interrupt status register must be accessed to identify the source. Suc=
h
>> > multiplexing is not new in IIO, and I have followed existing examples
>> > for it. The persistence setting (own attribute) to trigger the alarms
>> > uses the pattern that has already been used for the veml6030.
>> >
>> > The device configuration is in general documented in the datasheet and
>> > the application note. There is an exception, though: the activation of
>> > the "active force" mode that is required for the data ready signal mus=
t
>> > be carried out in two steps even though the affected bits are located =
in
>> > the same register: first ALS_AF (active force mode enable) must be set=
,
>> > and then ALS_TRIG (active force trigger setting) must be enabled. I ha=
ve
>> > added a brief commentary in the code to explain this behavior, which h=
as
>> > been confirmed by the manufacturer.
>> >
>> > The datasheet specifies the scale and integration time for the ALS cha=
nnel.
>> > Although both settings also affect the measured IR value, no transfer
>> > function, accuracy, or calibration is specified for converting the IR
>> > output into a physical quantity. The IR channel is therefore intended =
only
>> > as a qualitative indication of the infrared content of the incident li=
ght,
>> > rather than as a precision measurement channel. Consequently, the driv=
er
>> > does not expose scale or integration time as IR-channel attributes.
>> >
>> > The only functionality that has not been implemented yet is the x0.66
>> > gain (and its x0.165 counterpart when PD_DIV=3D1), which makes the gts
>> > helpers less usable due to the conversions required. It is indeed an
>> > uncommon gain to use (there are x0.5 and x0.125 gains) with no known
>> > use-case at the moment that justifies making adjustments to the gts
>> > helpers or adding artificial conversions to make it work.
>> >
>> > This driver has been tested with the four supported devices separately
>> > as well as in pairs where the I2C addresses don't overlap.
>>
>> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>> for all patches, but DT.
>>
>> There are minor things that may be addressed later, or in next version i=
f asked
>> for other reasons.
>>
> Assuming remaining discussion resolves, there is just enough requested
> here that I think a v8 makes sense.  This is particularly because
> of where we are in the cycle and the massive amount of time we have
> as a result.
>
> Note I didn't find anything that Andy hadn't already raised.
> Looking nice!
>
> Jonathan

I agree, a v8 makes sense even if there is no extra feedback. Anyway, I
think I will wait for -rc1 to rebase, make sure that no conflicts arise,
and send the new version. That should give enough time in case someone
wants to chime in :)

Best regards,
Javier
