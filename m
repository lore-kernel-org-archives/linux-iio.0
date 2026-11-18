Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968203;
	b=mQJ77czBHULakKFTCHNThlXieDNZIwic5c1G5Or2qKhkgGZsKuvCMLXFm7r8mE31xWvW
	 jFsia+03MvOZXIc5aSA1pqWqrQ4h+8Xu1ZiCfs+t0J1DH6XaovdYOp/3+a2YTJQkACMwm
	 amFkfhto0yG67bHP8u293aIpekXV62pEzw4TcF15Nazr8GnG+SqEDnFCccEUHcpvcTVV4
	 XJAuUAXFtmbzg74hK47g9hQ418w/u2kivHP0SvfpVpgOYNa54kMcu/CKU7xzM9GnOqpkY
	 Ql+d/D0g9qmBoHsXTlD8xVfFBCE8DjAIYbdx43wKEkN45VUD1buMeBHL7VUpurrv9lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=RUN4/XekwGukBeANDHZYj2pG8A+8Y1wLE0QDevY31GI=;
	b=nj8KBtaou3CJVOZKNeZYNvpUf7EzRohTNZqkG1NB0TBfBegTdjVpyYzsRyNs7ZL1ZJIe
	 XDuIpxSQzdT+qkUvZZU6V7l/NgmDhTGCM91slqYgJUF0c1JAndc6/CqqC+PSY1f4a+KsR
	 uNR7ocavaJNgvjy5knaA27L9OBv8B52i9+3ZjeAZEtlJyIqQ4+Mbz2yHw/B+MQhI/1QfH
	 8psVUXAdSewbDU6I0lKLuWE82j87EP93AAqZPmoSF0xrWR6F86jf62t8MQzKs/VlRgaA4
	 GtfmMap8UKFO3Z9HV1tuUti+waWpc1fZeMB8jlOrF1Z5BH9eHgrhFZTfQre+kzH8oEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aLvzh7Tm;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3243606A325
	for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 02:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3243606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aLvzh7Tm
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1aefd1bf74aso291923c88.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 18:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794968202; x=1795573002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RUN4/XekwGukBeANDHZYj2pG8A+8Y1wLE0QDevY31GI=;
        b=aLvzh7TmrJQmsKxZ3p4l00JnOMwV1+eSfabMwypUjc1VmM5qgDfZ2mE8VxdcKQaIlX
         E57k195r2iINV4t2BN+AR9LNERcwahvmpROMB8PJfCYXAXwmgNCSXVFqk73XW6feEiuC
         zGSYDUC0qi3vCoHGF5mI8WLPRqvyajol0jG+b8+n/rLnCf0QVp6X1uOHAz4gqQpubwaW
         Ts0YABGgelzj4tlv2eGuXrj5LlOlbzh4+K/Uk1VI9p1XwTwtIrpoq98bFzblWBVcHRTi
         xM+vRB3JF4lPDLcPUGivxMXmi3TJyVdqAbvhkLW2cV/EsMzksEcZZ6W0r4n7FciiM0c3
         AoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794968202; x=1795573002;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RUN4/XekwGukBeANDHZYj2pG8A+8Y1wLE0QDevY31GI=;
        b=N9n+Pron+Z/IqQggDOfBvoCC0Uq6t+tKVAFagG+xKjOvxyNkOVp4Nte3gsdFAguqyv
         /chtuX8MPQuhXzmZ5fzSgDFKz/VHSwmv/PFgxadgMdAeJYc0TKOh+i+LkAyvrdC9Xs9c
         IxPrbBuuBkzfKtYXouK6pAJ7pEQ8U6TX6MZbglDOIlrrabZtKsEH50jU7KOnDn1PthdJ
         wA7A250OfNsfYu/Q6vBIYuT7EyfWji8rG8eJONU+OcHlhQp1LScjup6EN0xskRGIIl/7
         MAJgNm4QwcnJL26shZjqZvmo+kL0mjKbefJdtcdM2UjrisqKx1SsQv2UYSuw5kautreR
         /0fw==
X-Forwarded-Encrypted: i=1; AL+hErF4AwI0yzarLcF4FaMFR6C/LljcIjXZFGQmPXZkQ8/t4fz7TuPVtTLcHlLukGelrlLh5TR8kfYTS1s=@vger.kernel.org
X-Gm-Message-State: APuU4Z841cxrLcV9f4luLQrDp+9fsERcnRh6GRwqAuB32CYKoKhsKHsf
	SRhzsJ+E/Ujk2OP+Vtd1PitVbtnqVhPehuSiW6oHen7M+Zu4SvH0EIA9
X-Gm-Gg: AYBFou1R0nmsTX2C7c8rcnyuETYCN80PLKSULQXYOrG1BytoUGkj9FNe3pH8yOX+Zyl
	6Y2XyWgsRLbqLfcdOZ0RM2qUYqGVnxv2n/vWzyL5SuKOgYVNaR18uphIL+41fSYtQadmhk8N3VS
	e3V6kXh284MdSk5PQqVhaQveDtsbBJgDcchckoMvpKd4LsTl1nB70Ru1TtrPcyWjN8RkfO0kQ4y
	6w3dP+AELjDJqz0ZqbV16tzs2hf4QQ/I9BIZVbm2bz4XV9tGlSui13OhwFE9rfI7JAnTY67423D
	vYxdjKi6/6FWedYBeP328j5T7ea8sPHVLBB6Kquc9dz3SFutGxjtKDklbpfZDHkpyKreRSdLptB
	fIHHz3upTUEFynW2b/ZX2VOHLX7YgD9HV69Brau3/XPh+bSJ+GiesLv+Hb4A1PnZJ7BO2sR1i31
	0x2G5t5roJIUPVK7BbGLM+c9kDTx3EGpzmcW3e+JEooNfg20DM2Ntt/P0P3cO378PgKevdy/bYo
	qHzu1PnzjsSqIH455VnbN0xe6j0GNc06TfETBeRWVxrohHJz26199N/bq4GsQlKOck42rnVIC/T
	m+6iovH0j4+rwcRAiaHYhVdR/bAWaZUSyc9t
X-Received: by 2002:a05:7022:b052:10b0:1ae:d447:6c84 with SMTP id a92af1059eb24-1b53a469eb6mr3927988c88.19.1794968201793;
        Tue, 17 Nov 2026 18:16:41 -0800 (PST)
Received: from localhost ([2804:30c:914:4500:cd15:65cc:e2cc:7363])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5446f954dsm2207436c88.2.2026.11.17.18.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 18:16:41 -0800 (PST)
Date: Tue, 17 Nov 2026 23:18:04 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	linux@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 0/3] iio: adc: Provide mult_fract() and make use of it
Message-ID: <av0K3OIrxq5Bkjpw@debian-BULLSEYE-live-builder-AMD64>
References: <20261117091638.1463621-1-andriy.shevchenko@linux.intel.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117091638.1463621-1-andriy.shevchenko@linux.intel.com>

On 11/17, Andy Shevchenko wrote:
> In a couple of IIO ADC driver the suggested new helper mult_fract()
> may be used. So, provide it and update the straightforward users.
> 
> The helper has potential treewide, hence it's provided directly in math.h.
> 
> Andy Shevchenko (3):
>   math.h: Add mult_fract() that takes struct __Txx_fract as argument
>   iio: adc: ad4030: Switch to use mult_fract() helper
>   iio: adc: ltc2378: Switch to use mult_fract() helper

For the whole series
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Thanks,
Marcelo
