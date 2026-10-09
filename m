Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA04411661
	for <linux-iio@vger.kernel.org>; Fri,  9 Oct 2026 23:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791587646; cv=none; b=FMK23ubuDPACDz3cMR7LM3VQedT/NkXCK0JH1jzZX8AMQjWV8NqLGMlNciDctV0cxNkoL4Dhi95m4i2uEnMMmzhXy7QsHmFRcuq/yaHNjTdbAZYwrQh/oL1uaQIcUe3WcvbrwPshtoB1NxNR0+oKcpe+jyv6eFDxw+MI+0eboek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791587646; c=relaxed/simple;
	bh=3ZSLLTasKr76GEJrzVSyl+Bcz5oJzIQqfkWykCzS+oI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ddLV9R89eZUkwxUZYLFLXECFz4RU+HysD4mNRzvlEumE7HAt0NVR1PBctWzae2X4QMA5mmuWESsSTxguRCRBp1HvCTJvMFHFXE1gMvvVKmvI9KE/fvUmd5BaLKe4gCSVuTvrqWXpzlIIy78BvoSzNU5hBNNb2kJTgHMQ5WPk97c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=KW2B4n4B; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="KW2B4n4B"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6de3360d905so255835eaf.3
        for <linux-iio@vger.kernel.org>; Fri, 09 Oct 2026 16:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1791587643; x=1792192443; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JEvNFYjzpJm+hMocPX+GyMaf5UQXS7PHxcnAyw39Bg4=;
        b=KW2B4n4BDcBYuF1mXpP0ncaOy9a8vjalps7Gm52gK1XwhuSSqRn2K/dHZzTOogsNTW
         8wY9tsSBNKpM4/PyH3nGXJD1uxHWjQbN6VjwgbX8D3CntW+S+u+rdseAz9dV1FEhErHi
         MYgTa0/cBBPIT7FtAmZkoHKJM0LdooJTT/shmanq93u378fXytodA0MIaXkD6zmElZNB
         f6QN7e5HTIk2R3F+sVljUTyYY7O+ac2BB2O/ePpiKPv7QsDyh1IGXB7rVgY7lpJRlv4C
         FtKmvOBhtwhzVzIbjobxi7KnGr5NTOSuELsvJK+6tfzBxT2qzoI9rbVntnW4xtbgEGI7
         N8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791587643; x=1792192443;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JEvNFYjzpJm+hMocPX+GyMaf5UQXS7PHxcnAyw39Bg4=;
        b=Gh4FV6pr/7Iq8Fx8pk70r7qOv1pndYv5Rg2OUfneN5c3i8PS5bKvG1HfN64BE4AbDw
         b/CU72yzlIaI2PzOxI65Vpy2+WAKylwvc1Tsms0L8RAg47a4gWrRQyKyaJPSxFFB5tUF
         HtsvRo94cH3A0CHg66lsSmda8p7SipdbndS8d2spAhHAGOMdbsikKA0hUI1b2DAjLTuV
         +eBlYo9VdP4ZbxXEJzmTrQ65vmc3/oBnwZ1kFL+CII9BC/lGOnx0i5qrR50X28T11ugE
         qJm4h7MG22GBNqRs2AfZQC01tbLTnjHTspQqFlltFMEdDPDMqYv7yuL95EE8Eh7ASxXD
         JtQA==
X-Forwarded-Encrypted: i=1; AKwUvByIEClbjld4F0+TlieDmyoZPBh6IJOu+8xzzUTtVYxQyrQBb089Wqo6EuHXm/ym8dKFkFnzd4skTc4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUXix0xKu5jY0Sn0/gmXpybWRHw/8ouYuVxJUn1f5qcaHrPzto
	cik8jmExt2ioYDyUo8EbZAwbS62oaqPmIDj42yP7GFa81zxavNRI9t4DnHISQC6qCr/YGqC/Tmm
	/Tz9y
X-Gm-Gg: AYBFou2rUfon8a6kY2Sc9Db8WalNbFxPTlje/142mzAokd1hUUohIL9pKJWtMoF6JnE
	SO5+Vkg7OBmsE271nBlpnvbkKuxby1ulp8M+ocMnroKpdgSjeJ35Gc3jd7FdzFCvXNROEQfHMSj
	BeamMKcqEzzBOM5Ihw+08zk37Kh/lXb+adm6F+fjXoRTR7ynCpNSzQ7+ztvj8IAIMTh9R65akAb
	+POGlC+0dpigLwhtc2MZWTFlotxOKFVxPBTlJIf5caYjTrKopvr56qXOp1G5JMJZJKIVHhxArpg
	DIQ+/Cmo7E1KexK/Aha5ij37Az62ZTg2LtuQRmxX0NCcPK5Fsrg9rA/5YRgYgDuK+ytOg6kzQmT
	mkrPz4LYxVV9KwZUyv8AaBBtVNWHuKwIEvj3ioFJNvrUXfR5eU1pb6311YzfPUBtgJCQ8J0Xqyr
	9aqGhXS5K0gfRqPxdOvnyCvJ4FUu8A5tS3T73ubkMFIk9C96YAnHX98uUaS/0oDrrS9IcLdgn7w
	DNyHyi0APoOz8gATiIzCGRoyogbrzOLJYZ+3u+5rOTfZHUh
X-Received: by 2002:a05:6870:6586:b0:49e:16bf:1f87 with SMTP id 586e51a60fabf-4a2a8a7ad2cmr2643174fac.38.1791587643522;
        Fri, 09 Oct 2026 16:14:03 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:29bd:56f6:5ae7:35d2? ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a8592e2dsm2982529fac.13.2026.10.09.16.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 16:14:02 -0700 (PDT)
Message-ID: <7d542de9-0c87-4a1f-9d9a-48af8431cba1@baylibre.com>
Date: Fri, 9 Oct 2026 18:14:00 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ti-ads112c14: add gpio support
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>,
 Kurt Borja <kuurtb@gmail.com>
References: <20260925-iio-adc-ti-ads112c14-gpio-v1-1-2a2b218ebf3a@baylibre.com>
 <20260926014620.3b07660f@jic23-hlaptop>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260926014620.3b07660f@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/26 7:46 PM, Jonathan Cameron wrote:
> On Fri, 25 Sep 2026 16:50:47 -0500
> "David Lechner (TI)" <dlechner@baylibre.com> wrote:
> 
>> Add support for using the AIN4/GPIO0 to AIN7/GPIO3 pins as GPIOs when
>> the gpio-controller property is present.
>>


> Even better if we give that helper and the mask shorter names.  resv probably enough for
> reserve for instance.
> 
> 
>> +				ads112c14_reserve_gpio_for_ain(gpio_reserved_mask, pair[1]);
>> +
> 

I tried the shorter name, but didn't like the way it looked (abbreviations
didn't seem immediately clear what they meant to me). It only saved two line
wraps anyway, so I kept reserve(d) spelled out everywhere.

