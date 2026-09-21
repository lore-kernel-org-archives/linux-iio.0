Received: from mail-ed2-f37.google.com (mail-ed2-f37.google.com [74.125.228.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3D0453A5E
	for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980409; cv=none; b=jrHV6xq8dOwcVfahEcCiq5E4/Oh/DxZmQcyQDvwcAePET+vIDfv1FWt2T5+Dgz0nBb2qLBPj9WkT3nstqnM+zuQydrdG7WJTuGQPRUsEJxJg3v4MafDImvDetYx/SDGQnTSfnw+31/X45J8xI5ykg6KV/azS7QoM9tYU7ULcoAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980409; c=relaxed/simple;
	bh=KyBH7dhUVR4B0av3A00svT+cy5avMnDRCt6F/8hLFiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIXpqNEEDLRbX6nQ/4I+jNqfPQOWWZaIg68aa+OvRQb1kX/eKYF3CwWH9RqgewkUZtusclEhZP2iFGjZrxQD5Mv+9R2TnUw7dg8BlBJwoiT92tAH6O42OFaJcQykfjOlSN+G/mzHvCBsIFsQE7WdNNttpPwb20GRHD3cQqIcZKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xde7lvO7; arc=none smtp.client-ip=74.125.228.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xde7lvO7"
Received: by mail-ed2-f37.google.com with SMTP id 4fb4d7f45d1cf-6a9984f9a59so3793055a12.0
        for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 01:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789980406; x=1790585206; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U83Tc5sQYnzc1MW72+9l9dJyYEc+FCbzixyfv/lGGEw=;
        b=Xde7lvO7wONq4WdJWo6Y4+36q0sugLQo7GicQlDObrmem8LfZ/gVLYU/J2MK+8WLTZ
         2ivBumskyL28bEmZAOVzELbUmX0SnMH2rRtgT8ZvVnuv9C+/LaB8PBlEvN25ATL+s6HL
         HAlIUK8ZHxacglxHdq09BfHLZi3O7HtmLllOlabGi8HV2sSF0qDwi4GiTMTSvu0XQFze
         /ALoNlmiU//wJL4Ff2F2H+fKfGxyYHQdxbD+vQG/CrRcMIgsedNa7QjQAlOUH5Mh31zI
         0WxL4FtQR5Ou2ds7yFd36eo+aXzqVdxNC8gcglkdlE1OnduVKtj+79o7rx0BNls/GL2A
         XFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789980406; x=1790585206;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U83Tc5sQYnzc1MW72+9l9dJyYEc+FCbzixyfv/lGGEw=;
        b=jpmgpuGTkxNhdZoppmpAG76d4R8n5hajOCTugTl1dkp5v8Jk3PEPM3nE9JAgUdu9eP
         pREf5AaWbqBbnhe5ISXnKwQ38n1mCjVeu+iPUCXWaUEBI3xCxIj+8x2lH2TBy4GDXB7C
         VAstmHCqrWGBaaGuxAfxsWhuS8d1jdCnYONv0wqYJBUN2KXimtS+XH63oLD6Gyl87IN7
         RHQGlu5ot3uALlE/5p6rqbjRwiZTgPljDPdy+EIslM/4mXYgWWGi1cCVf0jj66eJj8J5
         0Ul4u6QKxdvYUhHcj7j7MCHrkN7HTIpRp0ZS5XuglG3KL+BfH/+VIBtuQpRmDCy3UhL5
         E9gQ==
X-Forwarded-Encrypted: i=1; AKwUvBxhEMd9AroMX26ZE+krJqS9nXCbd+FxU2+7KWmF27ZU1+e/DaA6/epfEvqgQEnjZ91jgwWvDSO7P4M=@vger.kernel.org
X-Gm-Message-State: AFuF++kjIvaq4EF2Ecap3QhJS8CJBKTJ/KYPmSR2EDXY66C+mohmfkwR
	iSBDgwf8LD3bnFOCeufWzqO31EsfYjhYa9ecKyOOQ4541l0UiLuB/vdd
X-Gm-Gg: AYBFou0r0QRRIkGVgPBAZGchNUyzpRXSEX+tETG5ShxowDGgOwOZ+Dt5vhDLKEoua/z
	zhxS6JQ6xviZzthQlLb5TWLgiWS3FT729dvTHQMMfs7hVGnaw/9HjklaSeVo1pljX4Bg4Y5TX8V
	5NhKfnq9+NNmsUQGdoWce82pDzKzX4mKmQ2s/q+J5KvOUhqEmup+WZYzCCTnGgqW7E5yClfaMpe
	zD1710Yk9x6eaH7vWS0Jafjony8+fDcfbTSiOGF/ViUo8JXQTCMPhrB+dCRhEP9wwJAzKjiBQRj
	tcN0O+HRRuymVSrv4GWSWB6M90/o/KmjUE9V0ql9SAQmoPbKiJo11Tbz4VqzVA98j6vPzcSf7p9
	/ojcIhr34nDKwaAiyH2GgfHTiCBtpBaN5I0KHYfeC0yPwhCLBqFq7SwwbM/Xpr2PPMEtxY++aPP
	Dkkz8lnI6VvqOF/FLFbsrlF/w+icSrs3pqCzg4O/yrFlO0ImlaZO8ZwmWSr1rGgxNcBuW+/4BQu
	u2J3AqLLTY=
X-Received: by 2002:a05:6402:23c7:b0:6aa:4529:4cb7 with SMTP id 4fb4d7f45d1cf-6aa53135128mr7228644a12.16.1789980405879;
        Mon, 21 Sep 2026 01:46:45 -0700 (PDT)
Received: from [172.24.138.145] ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67d821efsm3882322a12.10.2026.09.21.01.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 01:46:44 -0700 (PDT)
Message-ID: <457da50e-a633-4508-a8e9-7e000933623c@gmail.com>
Date: Mon, 21 Sep 2026 10:46:41 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/17] iio: adc: Add AD7768/AD7768-4 ADC driver support
To: Jonathan Cameron <jic23@kernel.org>,
 Janani Sunil <janani.sunil@analog.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, Conor Dooley <conor.dooley@microchip.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
 <20260921013732.6c5399e7@jic23-hlaptop>
Content-Language: en-US
From: Janani Sunil <jananisunil.dev@gmail.com>
In-Reply-To: <20260921013732.6c5399e7@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/21/26 02:37, Jonathan Cameron wrote:
> On Wed, 16 Sep 2026 13:13:49 +0200
> Janani Sunil <janani.sunil@analog.com> wrote:
>
>> Add support for Analog Devices AD7768 and AD7768-4, 24-bit simultaneous
>> sampling Sigma-Delta ADCs with automatic power mode selection.
>> Changes in v8:
>> - Introduce the DCLK divider helper in the core patch to avoid moving its
>>    register-programming logic later in the series.
>> - Document why register caching is not used
> Other than open question on regcache vs volatile registers
> this series looks good to me now.  So let us get that resolved
> nice and quickly.  If it turns out regcache can be used I don't mind
> just tweaking that comment for now and taking a follow up patch to
> turn regcache on when you have it ready.
>
> Jonathan

volatile_reg would handle the live GPIO and status registers. I will remove the regcache sentence from the comments, leaving just the SPI framing explanation. I'll look at enabling regcache in a separate patch.

Best Regards,
Jan

