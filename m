Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CDB135A53
	for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 00:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787013110; cv=none; b=czI1Gbg40yrvgmuwrxWzxTIQmJs7ISBcTy3vH65j6+fu5UsFP3MNCUBXLLfOr1pf5cLOosulDihfTCRvXKASAGX8Sln3dHXbmqxNCwpc4igUiDguUAR+x62+uDXnd7J5B0CFWuc1Bqph/4Z4U41XYZ/CE/xjpLmnpuzTvaVDZks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787013110; c=relaxed/simple;
	bh=h1d6f5af3IhJ0FXnY1x1XMDRUk8/hQkA8E9L1vt7noU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Mr/TvaISCXrp7WzeC0nK9OY5JLDrlHJFE/z2S9QyabDCAGNFoIKobNjqRoWwFEbj/bRAZd8OudKXb4go1QH52wXuQ99Ua/XG64BYrBhtBUG3gOvgTLfH3gl6jxBl/8dLVPct5B3D/ipCnYZVaMDLXcVNwCRpGvH0k/eLmN3SSg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=KpPl3fVc; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="KpPl3fVc"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-448b0ff4a57so3721139fac.2
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 17:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787013107; x=1787617907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=68Kd4jn0n+scs+Bd1klRzYSaGtVCxQevZ2K9sSqiLVo=;
        b=KpPl3fVcpxjhVXo8cDrIB8w2frbtdW1udWv7U2M7rEhT3mZv28SLcOJj2arVSfJkNO
         JQIVupwus1jE1SI/TRx85bjRZXBaBVuqOuGddkVx+8NSFma3xGz5UCtheZSCNGH+wud7
         bK8JKbRoxPBwRrQWvHEtGGkxtuDEHF43Qe7j4xirHt2Ptss2sYlWC/6PoqoYjXaYoBvt
         W6ZT+O5r220QPSOOwlgihfJ4NyO3wv1cmfUoN7y+9O9+UqWaWbQERC+wphbYMASYeUBG
         wkPTJHwoaIdb81nLnC6AtxxZ8UgRAZGyODXaPW2N84h1Hgj5DN9tJMoVzhX0Fk41jNWm
         mIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787013107; x=1787617907;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=68Kd4jn0n+scs+Bd1klRzYSaGtVCxQevZ2K9sSqiLVo=;
        b=I2Q/02Cb2ClokEJVM6f38C6TgGM43TRNSNhddHDce4Liu0OoHVrC7zDFYJpsgY7XGJ
         jWpAvc+AnQ8VYo1qz2bQHdrXwFB27ZUnJoG6dX9FFzxnWxNn6Y14mGxQYfdSIXq+Rclj
         Y09ONmmmUZViJMrIl41heRqNgrtwV2IZ+mws4Xhthg3hVpt2cMutsB5l/xmjamHhSHoq
         iuB+Wkfh7ThJAc7nbjXB94DfdEUj9XZe6RhzVRqC2ROZgYtlFbHZ4D/6UDXzgWlKRNMV
         76LW3IJNaLL8TXiqPHnY32kLbWo5UrfZgOsjnEbwIdEXPB0md5Wd7h5Ser282twBlpkj
         oraQ==
X-Forwarded-Encrypted: i=1; AHgh+RotX17VyuX8iROXpN4lry/oY9gAIExj//i2UEhwArrte9s1/gHEvy/hHHowmiZz2muFocuk8sgXrBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfhPlBHSpLhZh2y5KjEUVGokbwFAPRvCoaxbGqnV/ZvKfHDr8j
	23kgeWcYnUk8NZASWlH0meBIxTXJkEFfCCWl0YaCWJoj7z8niookHvFoSunCrOEGUUI=
X-Gm-Gg: AR+sD12HUwsgpbgCZh1K9U7q3NSbfMfKwr7EIowUzN/4aspIr4l9euBuEJA2fXUyt0p
	jL//czxx9zPMFYJqvnM60j1yh31SdT60EHK9Zdp4yaIXsyvhbyiehva2DtbYzAgIWiK4HgmzTKv
	DW5pxo3NzJ/Bpz/5mxWsyyXgTnVuCCF1QbcD2M/Uvs1DBibeSA6vu4QQe0qLf30yh99vw69zyY2
	Hr7ewbTEfZanV0ZOf32dYXCvQATEfMptKacl7nyDbn9avRyJHTXoQpIaG9gR2l5JZTEFssjG2Th
	gB1n30+icasOfxtbf6VxBBEOBwO6CyNpbnJl+Ek/V8oj5asrTcOV59qwNu3uTpU/q2gVKApNfvf
	OFpuSJGZT4PJoLcRYfCsKh6te3uQnbO+z6irKIB6yErQ5kjXoyA8M6SxOH2dmnuAb8+fadpcNrf
	Gha11aVcaj/wIVk2PpGXyjrn2lTtb/Vinf+wSsenhC3zgQPE2pCron+u+93HKHkD5+R0qVJoDsh
	uZkCmXT1r/+BC+W+yuGiNLWaVYDAraZomYn1hl8yaKTI7OwNIQ=
X-Received: by 2002:a05:6808:159c:b0:4b2:8da1:3be4 with SMTP id 5614622812f47-4b28da13c71mr7022681b6e.9.1787013107052;
        Mon, 17 Aug 2026 17:31:47 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:7777:83a7:41ea:5906? ([2600:8803:e7e4:500:7777:83a7:41ea:5906])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2906a3edesm2241478b6e.0.2026.08.17.17.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 17:31:46 -0700 (PDT)
Message-ID: <cb1937e9-c2fa-4d8d-bd95-f53423d88077@baylibre.com>
Date: Mon, 17 Aug 2026 19:31:45 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Maintainer entry profile/contributor guide for IIO
To: Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
 jic23@kernel.org, andy@kernel.org, nuno.sa@analog.com
References: <20260817111825.000063f6@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260817111825.000063f6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/17/26 4:18 AM, Joshua Crofts wrote:
> Hi all,
> 
> I was browsing lore and checked out the ksummit mailing list, where the
> topic about guiding new contributors arose [1]. New contributors tend to
> make the same mistakes when sending patches, causing reviewers to point
> these out all the time over and over again. For IIO, this is definitely the
> case (I myself send an email telling people not to send a v2 in reply to a
> v1 several times a week). Other subsystems have a "Maintainer entry profile"
> that contains subsystem-specific process info (DAMON for example [2]) and 
> (sometimes even [3]) a document describing the code style of the subsystem
> (this would be a great place where to mention things like not using
> kernel.h in new drivers etc.). I'm happy to create both of the documents
> but it's always great to hear other people's ideas! 

I think there are plenty of new contributor (to the kernel) guides out there.
People just don't read them. So I don't think we need another. Nothing wrong
with trying to make the existing guides more clear/easy to understand though.

A subsystem doc that has our code style quirks and idioms would be helpful
though as I don't think that has every been written down in a single place.
Especially useful now since AI reviewers will read it even if humans don't.

> 
> Second of all, the idea of having a bot that would automatically detect new
> contributors (i.e. the email they're submitting the patch with doesn't show
> up in `git log --author`) and send an email reminding them of the basic rules
> (while also referring to the entry profile mentioned above) sounds like a
> great idea, but of course hosting and maintaining are pain points.
> 
> Please let me know what you think of the above ideas!
> 
> [1] https://lore.kernel.org/ksummit/87y0ekm9nw.fsf@trenco.lwn.net/
> [2] https://github.com/torvalds/linux/blob/master/Documentation/mm/damon/maintainer-profile.rst
> [3] https://github.com/torvalds/linux/blob/master/Documentation/hwmon/submitting-patches.rst
> 

