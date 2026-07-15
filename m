Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED174657CD
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118125; cv=none; b=VsTfG31IK+wtmo8+dME5VqKz2F6vgT9DR9Pt6sJDan0qw9/3wAfKP7U82mrNEl2xB6Jzx3q3y2At16spGHCPjhkQm1/wA6HvN3sfgwPDjztJwM7mslSfUH5cwsIYuuVJx68kHst0q7bTLk8yEE88N9Sr+HwBshEvCcDUw89YNmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118125; c=relaxed/simple;
	bh=c8+buBaJGMSrDnJBI//Ou5Zwaqm0ew1TsCZe1gWdAVo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g16MZSiITX1W/pCys+wEHISphFllPETz+vnAYX5rUSeSUccn77Xh5M4nyNmQmRE2yXLZQwtla9ZSe980U3m7OQCbL424TdBiGi0Q59JP/wvOXyc1DAVplQlDoyVC39evqvVvfIsRdHPWdDJI3Gz/thzdwHS69wg2/nJmMlyKAkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=CAJgIwGS; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="CAJgIwGS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1784118119; x=1784377319;
	bh=3N1Zqjfndfoh12O8JfCwnA/9yzVp6g+jHv5eU99EtmA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=CAJgIwGS/Syw5IE9bu1FBrKhDoOGIsnkwVasP1WmCvgZ4a2zrOtAVS2gdXrvZgmy3
	 Er6JjZK5BUPx0qk6XcKuGJ12p0U7TC0DmuSZVjVW+A5GzWSwrmGkoWb4A39hkHm20l
	 O5crc6m/IievaoOeew2rWipHvW6E25+UYRKDLWSztXMIGGACcBBY5r/sFBP6kA//h0
	 xDu3QtV0AZf4slYFevxkuXqD0C4TcvBrmDZMSRD7z96ICzQ23iaGd4Ni5CWSi3+Bab
	 MtAWYDrIFoiBLZmrkIcTxeGm2auyOfLeuM9BsWmKk2vMCT803ZX70S0vstx9iWSq6z
	 1Iy+e2BmK4gcw==
X-Pm-Submission-Id: 4h0Zzn3hYNz2ScPx
From: Esben Haabendal <esben@geanix.com>
To: "Joshua Crofts" <joshua.crofts1@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>,  "Lars-Peter Clausen"
 <lars@metafoo.de>,  "Rob Herring" <robh@kernel.org>,  "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,  "Conor Dooley" <conor+dt@kernel.org>,
  "Martin Kepplinger" <martink@posteo.de>,  "Sean Nyekjaer"
 <sean@geanix.com>,  "David Lechner" <dlechner@baylibre.com>,  Nuno
 =?utf-8?Q?S=C3=A1?=
 <nuno.sa@analog.com>,  "Andy Shevchenko" <andy@kernel.org>,  "Martin
 Kepplinger" <martin.kepplinger@theobroma-systems.com>,
  <linux-iio@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: accel: mma8452: Allow open drain interrupt pin
 configuration
In-Reply-To: <20260715134053.000012d4@gmail.com> (Joshua Crofts's message of
	"Wed, 15 Jul 2026 13:40:53 +0200")
References: <20260715-mma8452-open-drain-v1-0-b1dd2a440c60@geanix.com>
	<20260715-mma8452-open-drain-v1-2-b1dd2a440c60@geanix.com>
	<PLKuTyVcES-o-CEsU7WA3Ir7-phI9WLM9PJ5UErJeahWgus8heVF4GPky0SC-EpaHLv54lZya37ivhub3W9kNQ==@protonmail.internalid>
	<20260715104542.0000433d@gmail.com> <87pl0oo5iq.fsf@geanix.com>
	<0RfJ6kNIpjdTDIh2uWC-FK3HRObOpQWqSWRm6hTgOFq6_wdHDyRfpatKMsvApvfFc0r-ye6piEWG888mBhp3yw==@protonmail.internalid>
	<20260715134053.000012d4@gmail.com>
Date: Wed, 15 Jul 2026 14:21:56 +0200
Message-ID: <87bjc8o32z.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Joshua Crofts" <joshua.crofts1@gmail.com> writes:

> On Wed, 15 Jul 2026 13:29:17 +0200
> Esben Haabendal <esben@geanix.com> wrote:
>
> ...
>
>> >> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>> >> index 7d683686dd9d..a20c02ce0b9c 100644
>> >> --- a/drivers/iio/accel/mma8452.c
>> >> +++ b/drivers/iio/accel/mma8452.c
>> >> @@ -81,6 +81,8 @@
>> >>  #define  MMA8452_CTRL_REG2_RST			BIT(6)
>> >>  #define  MMA8452_CTRL_REG2_MODS_SHIFT		3
>> >>  #define  MMA8452_CTRL_REG2_MODS_MASK		0x1b
>> >> +#define MMA8452_CTRL_REG3			0x2c
>> >> +#define  MMA8452_CTRL_REG3_PP_OD		BIT(0)
>> >
>> > I know that the defines are completely incorrectly aligned, but please
>> > ensure that at least all the defines in this block are aligned.
>> >
>> > Also, consider sending a patch which aligns all the other defines.
>>
>> How are they incorrectly aligned?
>> The all look perfectly fine here (visual tabs space set to 8).
>> Should I convert all the tabs used for alignment to spaces?
>>
>> AFAICS, I have added the defines with same alignment as the other
>> defines in that block. I believe the misalignment is only a visual
>> artifact caused by the diff format.
>
> Ah, I meant it as currently the defines look like this:
>
> #define MMA8452_WHO_AM_I			0x0d
> #define MMA8452_DATA_CFG			0x0e
> #define  MMA8452_DATA_CFG_FS_MASK		GENMASK(1, 0)
> #define  MMA8452_DATA_CFG_FS_2G			0
>
> but instead should look like this:
>
> #define MMA8452_WHO_AM_I			0x0d
> #define MMA8452_DATA_CFG			0x0e
> #define MMA8452_DATA_CFG_FS_MASK		GENMASK(1, 0)
> #define MMA8452_DATA_CFG_FS_2G			0
>
> I'm not sure if this was intentional or not in the original implementation.

Ah okay. I assumed it was intentional, hinting at the hierarchy of the
defines.
Should I flatten that, or is it okay to leave it as it is?
For what it is worth, I like the current format :)

/Esben
