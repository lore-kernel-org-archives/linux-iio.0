Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101CF330B06
	for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772196572; cv=pass; b=qeoMdo7rIezCHL8qOh3SB9L6iekXQhpcjpVT5Qtsd7HLs5N1x6hel+v21zA7u++Y7XcZJO/mjQGTPRSpPbKHu476+stTgR2H6YoMTOCEbQSuRcoLEZ1fGYy6VBaHi6Q91vW7vqDWBkS6aA1hPm84jACCV8INMDDjWDkyGpiWUXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772196572; c=relaxed/simple;
	bh=JXoEWkMA18GEIgn/Wt84CCq21kzcsr7VoHJR/wykkWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQrV2VnPlWU1OFqqe2n6g4JGVJMND0zISAvdUdY70g2Y/rYIIcWj0GiSP1+mLfTueihCTNG0P5bvW8j5YX/0IjQSRrq8ItIfDPs9lk7lVMagk6dLvv33FZ1c1pXD4QYhH6Kw23cApObyMKunCZffIDWIme0LVEmhsk+ZJhuokJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1MTF1YH; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1MTF1YH"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-358ed90bcefso1102833a91.2
        for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 04:49:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772196570; cv=none;
        d=google.com; s=arc-20240605;
        b=lTD5OLjoFpZ3Hrsr539P99IY43Yu4K8+N+V35Qx2vjFGDfX3+A1wEmdlaZjmjTT829
         HhieArFmFK9VxDhMPeiKfVOiLXi9lhbat7wy8wqTQOzQQ6vPPhqYCHosR1saLVxB9j0/
         dstC+uyIOHjsmP9tN0eXSrp0nBb6xajYO+SrUm6+JBWndb2H4+i8wnsybsk2TgFSYOkd
         MIiBvS0l8doLE1i/FrOhtCT5crb1eswvry6xyt0O1aI4WdexUZSPDsYenyPOByS0yaPh
         MStQJM3F4ctRS6T/fM/thHztGQpVS5hnmo7l8kfsDJ6Msv0CvAknXeQ0uXDG6oQQBe4c
         m14w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ajZfxwhp4Mupg3TLTAza+3+UCxM49Q2sFdfPOhFN+a4=;
        fh=Ykgp6CC2X6+lC5Rrx3Yka7BiAvTOyWYyJQqrx7nMrDo=;
        b=QfShjvAJngxzkKL9nEqg9VtOVB9Rf5+HqRDrZc4YtA4IJJY3zHGBr7KrTmTV335XBi
         WRQLZOZpZzpxxoFIod7LPoHwIAbuPMOcaAW6UKrvmC62lMecHkzgcOJlzMmptp8ByFmp
         7QdVTzujEonThGbutmCw49BWvKiWd95jq7kGugw4rODDP3zH2ttcvJjn7z7+VHaSCgGw
         /TS7TUUqFt1IHaAZ/rj7EPVtS/pnEuYMxg1J9nZV7poItatUwyi2k6oI0QUTOudeP8Le
         LlZzMBMErBrewF5xcVhgSFhRnL0cgg2ugkDRNWJ8Zs4YHsRRSifKmokjG+6Yauk5bPDV
         cAXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772196570; x=1772801370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajZfxwhp4Mupg3TLTAza+3+UCxM49Q2sFdfPOhFN+a4=;
        b=B1MTF1YH/OYyYwwi8vZsFj2dgNhs8GioW1ZyzbjMUpXHA55t3To1RNPv8BpEV9P/4p
         f0l9JbbL0vOo6G9y2bwqr8YGt6BJSZij204GnRN9Z5/WBHqVoZZ6GmXqYYEQf3dckTjY
         lJG9PBKKpt1nHiIxU4jaBPhlyItpARRtDGjHJzlyg+0xZqun5q03uf1bOBdb+9KTvOLL
         v2+aFGC40ypCJFs0fqvBdTSq4bmu/WkB3Hla40LblPqC7sOdk+kDJejD7QctPzRLy+8A
         FxN9I38q5hRvCGsUmkQYADz6Ol1b9+wYv64Efyvhs9CRqU0xjFIXz9yC8ORgIn8L6OlA
         NRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772196570; x=1772801370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ajZfxwhp4Mupg3TLTAza+3+UCxM49Q2sFdfPOhFN+a4=;
        b=Bq0KEJfwfaO6bk3ayRNim8Tq6bFw516BcdFUDUmkRntBtbZJnAw4F6bWVOOApn5rHR
         iKhf60RyZcmSpTz/TDRuSExNcXnoegPWCREITyzn8IGkT5kDH/fxFcGZTkiREet/AZZd
         ZoDD0NganInEhaCLsBK4xtZewiVNVuF6XNsm0tHbmvP+HvPDXmiCUYV2iFsH5puoJU/4
         OeFqVAec1RMWOMzbY51e277TI2b3LUYp75iMZqleMg6El/3ajEwcaTHdB5RPczOkxJdX
         Znhjtav/YigmvbMr194Rf5gm4SP5su8DYevikkgwI/LbNLvDS8ChMLVjirap4zfUsfhF
         j+jw==
X-Forwarded-Encrypted: i=1; AJvYcCU1EsWurxYA98HxnBTG6V1f5NLGIWPwrrr4+nzWtqPpOO3t2M1nD1r1+rfHz0ialUb8WLPU63CbJpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWN6KAr9XLZcTPuBmjt4B9RSA7oRa6xH6TzuLZy0sHjvotvT3z
	/EpKNrUVR+XJRd1B2xnxHztpf+TXOr6z/gZsa2iKA1och+9ARrITxcer4PDJlPEo+9UkVGCQd4W
	qzQdw5QiC7MupkWNBennhVXaJ7B3lTd4=
X-Gm-Gg: ATEYQzxWsu1D2IWgi1RqXI1t/WzzVo0grMD8zOVTilQgH/bkUGccEEzGonpmLlmvv+j
	u756ZOTTxxxhDhK6LbQsO3gWcZBdBcq5Tpn9FhroXMelyamaHC+bpPUbIaxqiiBNl3H3bciaMpX
	T0XsKrZKbiZxX0/ex8sRw9u21kUGgEhn77iBI5G5Nqrfu6Or+0jp9+M3g+Qp2XTTW9mbrioCbGs
	alawH6FnB1k9gq4FyzE4we6vf36SoNBWY4wHZ59X47wedERZcjVFp9Xk/EgQf7+Qf2FDB1cpo5T
	C8njghMqr9RYX/kyKO0=
X-Received: by 2002:a17:90b:5390:b0:340:c179:3657 with SMTP id
 98e67ed59e1d1-35965d17f5bmr2959302a91.33.1772196570145; Fri, 27 Feb 2026
 04:49:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227-abp-v1-1-b6fed0545852@gmail.com> <aaCnYxWE8vuOEimE@lipo.home.arpa>
In-Reply-To: <aaCnYxWE8vuOEimE@lipo.home.arpa>
From: Felix Gu <ustc.gu@gmail.com>
Date: Fri, 27 Feb 2026 20:49:19 +0800
X-Gm-Features: AaiRm53ct_3RuwDAq2xrKO5TCjjys925psRweZlQwchJ9q74K76jV5Q9SZlLTNg
Message-ID: <CAN4SLj3QbpAwT7CXv4fb3wCu56c_38Bjsv-wTor0yLbq3R5E2g@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: abp2030pa: Replace IRQF_ONESHOT with IRQF_NO_THREAD
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 4:04=E2=80=AFAM Petre Rodan <petre.rodan@subdimensi=
on.ro> wrote:
>
>
> hello,
>
> based on previous feedback [1] IRQF_ONESHOT should be replaced with 0.
>
> [1] https://lore.kernel.org/linux-iio/20260114121448.00000249@huawei.com/
>
> best regards,
> peter
Hi Peter,
I checked the handler implementation,  IRQF_NO_THREAD is not necessary here=
.
I will update it in V2.

Best regards,
Felix
