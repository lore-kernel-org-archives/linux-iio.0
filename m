Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E984B8DE2
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 16:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784045420; cv=pass; b=EtoRnCTPmrUpP2SXqpV7RNhoJln6rNHjB96Ew44HNfuudN1s16pvYsD8hGiaxJqgoHN/ERa73mOJmdIpL2NvIzy8H3j7ljZGqJ990yX8xXkgI/3HS7rUaMxNe9xMDev4uDPqfW3GeUCimwOFiYS+I9LDBQMsgQtISn2//mzvRlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784045420; c=relaxed/simple;
	bh=1S0w7dm+YUg+3fSmOHXRext4Zgxg1DDIp+QHb1N2Y68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6fAnMq8pgp27TLImMv8HO2OF4s8GCHH/NptObC0tiGwABitofXkzQNh3NUuym08X3E01T1EW6nap+xhmbDzWM432FSahikfYnUV//Cs7lzCR+aYUtdZQdwYinfOoWXRAdQExLAGGr7LZydDiM3fn4CJrhHbUlQCZjlF6SpJBOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ck0d+Nf3; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ck0d+Nf3"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b018fe8318so916178e87.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 09:10:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784045417; cv=none;
        d=google.com; s=arc-20260327;
        b=Gt2Jn8NUaNFK9QLvgFhkJdee+syuzUb2B8rd8fkDwaf2iiB0kOyicGGSR7y/XNUlNY
         qrdr8IdolAX5myEWlsCb1kgLxmoz9N+k/7KSr4SFMZppxbkTp8hKCBCYV5kBlCfRhZGu
         E9hQYQtmqhtWHZo9ZrZXMEAlH9lfA78Ap47xd9Z5rNoUy8I5rzVzS6AcIxvsTg5ULS3x
         EPxMUqRCK1ueZFmELtYRqRpQj7A+mUfhn1gHxe9pBGkl6GBSBao+h7A10kO9AqPhHQ3v
         YGaXW9jt2IQIjwRuItFajdP1HnejceFwQemrPb5O3FWS8MVSCnAMIay0BPlG6W8syNV9
         H6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1S0w7dm+YUg+3fSmOHXRext4Zgxg1DDIp+QHb1N2Y68=;
        fh=354PgMrftZcx74djWNXeBs/Yh42+G8TR6EPnRfyC7FI=;
        b=k1I8TYDSVajo9y4LpoVS4a2BM7nEmcG5/1WPtUv62w2q06u+U3CR4M38V20UvbKABp
         iq0HWP80EJ37NXk1baQZHGrsZPq6JmVnuARtpqfxS5ZQu/yiQXGQUE10B2sj3wZHlY8P
         TRfKdltp01zKqHF9laL55gm8OvV4j6W+fGP7G82KonDhr1w1/vUywjVuKv9wkMHCGbeY
         7nVbPicx4e4kL8z0/judNrmbtrFWp612cWSfP4uq/fld2Dm44/1q3R+J2ANaORI5i5jZ
         WOFj26doZ8cs3+WuinpgqoGt2AsJrmN9eaTSygqIhf0uVYHvEYEGmeUSAlkuDZtojk5w
         v0Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784045417; x=1784650217; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1S0w7dm+YUg+3fSmOHXRext4Zgxg1DDIp+QHb1N2Y68=;
        b=ck0d+Nf3NUDdCNwVj+cmbx8ZMWebrGRg0wU9Ev0rW/LdyouvXxinzXoqdLPt/YOFzY
         ToDs5EKOyW7RJ9m4eKKQVow3pNXnQXglXYkhkSceYMPn1tw0PqsAWzevfmA9YLTj4Q0w
         MlwegQJDH5hosvrZoeyErqwMATX6uo6hvIaUWMn83nDJi/9hgABcSRWqBMbTivJoZHci
         lVJqKPzs6+G9Zw34I1d6i8QAaBtcqQZEdELu5x2KDBVLKIpmTVLg8syLjx5TbPUlyO3y
         oTJCOWGdwHubUcNwryawW+y+W7lPAWIqmG6S2cJGVIoFTaLbBgtzGPuYIuq4cWNr2Lww
         CGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784045417; x=1784650217;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1S0w7dm+YUg+3fSmOHXRext4Zgxg1DDIp+QHb1N2Y68=;
        b=aSM1oTdk3mQeT/qTgG9NvYwwywEldSokxh140nehtfGTlqAHMvy7J3s80oS63NOIYt
         CCaZxUiDEBCEpfZl5jl6qsdTvOEf3prQhlvWeh9KMUQuOVTVYOuCApdYTaADRL6pmgFq
         15xUKGkjeZjWU2305XNiMKlE54cHgq5uyLF83ypA/gySmFRDgll5NrQFJ05SyEeGsz0a
         vpVjjZ7Ifoqvd0LPcKPMJNNhUDslM7g94kFm5jancdAf+8Ad7pRbr+psCilj3EgwbTIe
         E/tC485V/ZipfuRTB8z5eheSJQzmEinLgYDoB2BJsYaWJF7RlZxL2WvTh+tT62pEo7Oi
         ikCQ==
X-Forwarded-Encrypted: i=1; AHgh+RqFuE1L6tcDhYMD6cZ3NrtuJ5NzlIP3nr7FdbBrm/9Lyxi3l7DJKK975rINZOw7NlKLWw8ZfHrCDgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgrgYr4oy/DiuIp3zNXyjRc3dZgRO8yNk82GfTfbq9zxI9pR77
	si9iLQEBy5J3JjXFBD2frzFrq2LPYgbNQHK7c78WHDpz0cCVtGfemQk78lwio7TBjYIene0tNkm
	qSuN32T424u9ATIKckJ+1C368Q1U4wJw=
X-Gm-Gg: AfdE7clY1ZPzW3pihtx/TzkMYf0P7DRL8FQ3q3Cw4lsBWCQap3BYdf56EFTml3EDnru
	GU2kNzva7lhU3Zh1mns0yet03q4rP4opoxbym+g/5FpxAas9YXHjBGEbY68iqq0j+cYLf48XQAS
	Q8nFIrH4f3H2VuighCLU+6Xw/viu23ttSTF8s+NAJESLbCzvqYfF58aKFgCbd8t9ZBaLAkYRXvO
	otRW3MFanNTatwqG3NUtWdcLtUbLNRMC8dYavKknHj/GQnfVfIuW0QB6IF0Hkv3k56Ym7E171hV
	91vPCpF1x9z9Qe+j610NUmgSCpurFCc=
X-Received: by 2002:a05:6512:250f:b0:5ae:ba27:ee5b with SMTP id
 2adb3069b0e04-5b023698580mr2990182e87.40.1784045416281; Tue, 14 Jul 2026
 09:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707151542.91997-1-muchamadcoirulanwar@gmail.com>
 <20260707151542.91997-2-muchamadcoirulanwar@gmail.com> <DJVQAMP6ZPH2.1X68IDVBOMXGQ@kernel.org>
In-Reply-To: <DJVQAMP6ZPH2.1X68IDVBOMXGQ@kernel.org>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Tue, 14 Jul 2026 23:10:04 +0700
X-Gm-Features: AUfX_mymuGx4LGuheBapAT0SbQMDCl6HhaNslE_Je5xKU5wY_Z1_u4BqSMiQNB8
Message-ID: <CAO26r3TkGm0Puq0yJc7HyxMAujioLAs==RjGTiGUANzkHGb+Vw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/3] i2c: rust: implement SMBus read abstraction
 via kernel::io::Io for I2cClient
To: Danilo Krummrich <dakr@kernel.org>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	andi.shyti@kernel.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org, 
	igor.korotin@linux.dev, branstj@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Jul 2026 at 19:08, Danilo Krummrich <dakr@kernel.org> wrote:
> On Tue Jul 7, 2026 at 5:15 PM CEST, Muchamad Coirul Anwar wrote:
> > +impl<Ctx: device::DeviceContext> IoCapable<u8> for I2cClient<Ctx> {
>
> Independent from [1], this must not be implemented for any DeviceContext. I/O
> operations require at least the Bound the device context.
>
> [1 https://lore.kernel.org/all/DJVQ852J7SOH.26YBIJTQ9B66G@kernel.org/]

Understood. I will restrict to I2cClient<Bound> in v5.

Thanks
Coirul
