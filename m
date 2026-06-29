Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404584657DA
	for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782751657; cv=pass; b=L1aQmQJQzCTQCzPlJYvSegOub1dlU8KcKWN4uDy3VrfcttUdwJuZw/lR0FX5CXCrwxK7gXCUMIrONFtStQ2I5Miga1psmynbGq0TTrs1fgwSzgC57G9uG3XMXDF5xffbyPkzCu/rx8iaQ8Swbr3fZS445ipuYC0Zb8N+SxdOEXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782751657; c=relaxed/simple;
	bh=tBpXEs4b12PdFKZ5qWeLI8+rTNsHCCaM/hrxzWpfqDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVYPZ9VL/unOoObKy3SQCbU1hfdUeZBZHB7nN2a4QocbqGCfZ5MxTz5POrc9i2IahFWFsvHSDcBx1MOs6KzgXh3mPGBLXrgJ5e64iDuAWcPHl0VP/jSo84kB0D40g/PRNJI2jdlfzHJCp23jbx3dOatWYpFPwpjheONv7k9QsDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkHrbVgH; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkHrbVgH"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30b9e755555so6097240eec.1
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 09:47:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782751655; cv=none;
        d=google.com; s=arc-20260327;
        b=TM83T60ArNpFq6Z/uwxdwcMJM9LY25KDzUt+h7Z77Nr+v8++ps368QIFMpfJb5gluu
         aqO43ucXCPvm2513LEm//huvXZ7khNQH3lk6dLb4hkn/zYjESwqYp8DQfc8LXqFUeZQS
         rx2zoohMjbINMwFRZvxtmm5H+mnOY1HwabWs7L8Df00TAc1nh4ewHTLl3mlRdrKUj1i2
         RZOY0VUFA6m54SPYBed6bN+CiBUnqOOsZaqKcu7YDRufV8UUODRzHDRKdwBsTZF2WPvV
         x3E6A9VrqKxvfL04PNvhPZgMxk3IdUIUFuBOC2/wjrGa91XbJfWrf7MJOB4D9OmltXdU
         Vp1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=601baKGJW1PrXMaYCYLVau32k8IxTv3AZbP8T2S5iVI=;
        fh=1iwaE1Ha+NTT8xhkwsBMnjj2ztZRpM0BydeUjILkeMM=;
        b=iCD7WyWjVHAXCUJqQI1HC6XppzVvbbTJEALGCqsAlLzlLgbDgy5wZ3igcrqv50HFXU
         Sp/BM2KNscR8R3apnTNwQxdPYLajq6C442bo8dTBcYC4dHsXkJo0i/VBebU6G/0iVIdZ
         FIZemxxobMLwJPGXFwH9IG30vwAG/SKOWQ8ka1b1udgZqlUr3oxbminWjDrvmx26Q37r
         YBoNtluyFVDVZt5FrhL+rPMLBeYKJpf3RKDZOgzenJRr1aKTz05RGZ7LCa4Sfbq+vH3O
         r6z+WsVfGV4d/W3zwtP287ZxdfnOI+X101ifPzkcPsrLqANwiobrmL6bjFz6WjJ7mIMW
         jTxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782751655; x=1783356455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=601baKGJW1PrXMaYCYLVau32k8IxTv3AZbP8T2S5iVI=;
        b=MkHrbVgHH/mcTxBUJfQDzJ5yQQqVCyTcGa8C/2GC7RiQfkS1gkrpkKKm9DTNnvVxuD
         p97uP9jtkNKFc5HA+wkZKYEroPXwORv3Gp5lZpOYlb5TGd4dHe7LQ3D8dJDt7ZwyLSbY
         q0uglD25mQUv1t/ejNxR6HfGKWjh6GoZsYPT0WbMnYKIa3QWX1BBhDT3wj+8YXZZCPY5
         pU4FYEztGjD29SKfDca0Cau2jccQUvg+Y31uH3YYtkvabrN8GBG7qR8K7GJPzzltsQil
         UWlqsRi0rGYXtuG+LI9dj/IszgF0ntRT4NR6IcyTi/Gc3wktZOY4bP28K5O+l6xv1Ksf
         C2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782751655; x=1783356455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=601baKGJW1PrXMaYCYLVau32k8IxTv3AZbP8T2S5iVI=;
        b=W3/iXepr8i2BZ3Wf5gmBNzdKksaBqHsklow0a8nuxqOP/U6RnCjOUiVsDHSo68bxEB
         6jltyI4NFjdTqi7VIuasG4EZnPol2/4ldW5j8dcUPksur2WLfKL8hEA2BumvgnM7bv5k
         zZGWtAoRnbb1CHflgHJ/Nrf0NMPOiMqJ9181jnWlsSngWNw5/cvzHmTpf+c7W22fH+Y0
         YUiQaqzSL6VA+GP9D9bFR7v1mNG+5yag7AmIqs7fWW+QNWrJrSoE4vOglsuP1m7iqEZN
         q5RsQ4u71Ywjrz/URBLmqtQAtBCr4I/HzV1L/IlWkWBT9mVFSVabNkhXFlr/XpVglJj+
         +UBw==
X-Forwarded-Encrypted: i=1; AHgh+Ro8ESjlt1F8r9V3WuASRDkhfKFAAB1umnhM3m1yVDJwtxze5yCqQLfeG+6SDchAgQZ5IIYhvXqpZ+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPNBRkV1AEOBRDvfzivYQn1PSdTKMQ5pUj8aHbI5WhWi8iS51f
	4mZdMevd+48KVQ5A4PtynbObZvlZ+eHtJAUmLDoYYjEo+QFgwMoOuPI7PuPmLSkVec3ApWgCo3P
	fh2hNcgphQKXqXBVAT2tXWUYnMmUD/eM=
X-Gm-Gg: AfdE7ck1WwBsbx2CMam/Iro1cPM5QlOaRFNexop9Zl9q24VRefC6Es2dNLNlnqm9yLk
	JRoL221ZDHv4btwYefxexgCUm+Hruw4K4Wu4wltgKssXGDUbV0H8ZqKHyDPRV6/JL0lTxHvQj4P
	UVc38deoxYire+VL1ADxnxuz/5x5IzsuItu03xkyBfAo8aBAgd9LRxJ5YfMdJhiYpau2o8hJme1
	4d+Csd1NWPHePRogOfWy/powlVMUdbKF19A8Z7Eu7njvrgoWpfA/JV5V1xgXzMkGkI2zo+3ExUC
	vSpB9SkFIX+Qqvu8DjmgP5rxNEazhH8leqWAdMPGj8fpMJLIJWCzgVZ3snp7
X-Received: by 2002:a05:7300:6404:b0:30b:9e56:e547 with SMTP id
 5a478bee46e88-30ee11d7ac9mr202818eec.6.1782751655331; Mon, 29 Jun 2026
 09:47:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628191337.937-1-kimjinseob88@gmail.com> <9b179166-3057-4867-be04-b071a809f70f@baylibre.com>
In-Reply-To: <9b179166-3057-4867-be04-b071a809f70f@baylibre.com>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Tue, 30 Jun 2026 01:47:23 +0900
X-Gm-Features: AVVi8Cc9YZz7_2pOlAonXf0N4-dBQu_ZF09jB20zGNo43CtfKyfG9QaFkvAGcio
Message-ID: <CALMSewKHWfcq5D-0Bi8gAnCAUep6D1=HrgaM5WP-RucdU3fYmw@mail.gmail.com>
Subject: Re: [PATCH RFC v6 0/5] iio: add Open Sensor Fusion IIO driver
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andy, you are right. I should have included the previous-version links in t=
he
cover letter.

I also did not consistently track and answer all review comments across
revisions. I carried several comments into later revisions, but that was no=
t
sufficient. I should have made sure every reviewer comment was either
addressed in the code or explicitly answered before posting the next revisi=
on.

Sorry for that.

For reference, the earlier public versions are:

v1:
https://lore.kernel.org/r/20260520072843.3593-1-kimjinseob88@gmail.com

v2:
https://lore.kernel.org/r/20260524085312.15369-1-kimjinseob88@gmail.com

v3:
https://lore.kernel.org/r/20260529121005.1470-1-kimjinseob88@gmail.com

v4:
https://lore.kernel.org/r/20260607234343.22109-1-kimjinseob88@gmail.com

v5:
https://lore.kernel.org/r/20260616072242.3942-1-kimjinseob88@gmail.com

v6:
https://lore.kernel.org/r/20260628191337.937-1-kimjinseob88@gmail.com

David, understood. If the next revision is just asking for normal review an=
d
I do not have specific open questions, I will drop the RFC tag. If I still
mark it RFC, I will state the specific questions clearly in the cover lette=
r.

I will not post another revision until I have gone through the previous
review comments and made sure each one is either addressed in the code or
explicitly answered. I will also include the previous-version links in the
next cover letter.

Thanks

Jinseob


2026=EB=85=84 6=EC=9B=94 30=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 12:25, =
David Lechner <dlechner@baylibre.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 6/28/26 2:13 PM, Jinseob Kim wrote:
> > Open Sensor Fusion (OSF) devices expose a UART/serdev host interface
> > for a sensor aggregation hub.  This RFC adds a Linux IIO driver that
> > parses OSF frames and creates IIO devices at runtime from capability
> > reports provided by the device firmware.
> >
> > When the corresponding capabilities are reported, the driver exposes
> > accelerometer, gyroscope, magnetometer, and temperature data as IIO
> > devices named osf-accel, osf-gyro, osf-magn, and osf-temp.
> >
> > This remains RFC while the binding, protocol subset, runtime discovery
> > model, and driver-facing ABI are reviewed.
>
> If you are just looking for review and don't have specific questions,
> then it is time to drop the RFC.
>
