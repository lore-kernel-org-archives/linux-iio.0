Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07A13A63E7
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778660175; cv=pass; b=YMTnl9ed1Ibj6ZfK/NKsFSBI2fDVzSYeo3lgO7CY6XH4Z5K0D1rvDrFq3SKUQTT2BRDWpVnLZxDIVj61rCdyCYjqiGsRfA17FksM4JazsB/fD4oL/XmdtnY2C50T7SNvu12K4JP3mE6Dqj6FDWESrQnVnA82eqIGAdbyr0YGquA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778660175; c=relaxed/simple;
	bh=ud4cL8xhsO3841KsQ5TzRgbWVYyYS0uWZRLaIyi0I4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emtJLHsHMULpY04FM73+bMblopXCr+aXRLGyoGtQ40FxNtf95ur+DICLhBOURVClc4AKUz12okzf8MUFqBuHpXaF8v9OQHUlbw3AK42qZXEzH0RZncMDzNNVVNFW4JgxBbNlIcu11o2QB1JZxae+L8hz19ScVO2M6wOmjwut+rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7dORv6z; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7dORv6z"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ba840146so57858295e9.1
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 01:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778660172; cv=none;
        d=google.com; s=arc-20240605;
        b=LZM7thIWm1CuWPN/4lrlOGfnP/uAfqW+9iP0jrOwooRpVZ0yK3EU41V8ARyslluA5O
         QPJbyv/8Y1WFHv0Y4saqAiheIiOuyIdUZHhPU2kiKm7upzLlBn48agFouxZ2YZ1/3d+R
         D3iJVlZjPFdnc8qKcUX8X7iJK64zfAEAsthnvjGTOLy79p/KXrIZRiBbTzn8oCt5s9Bx
         JM4JrGz10cp5qaGcDzoKRt8z8C1Lj59QQb1VN4NcQSX+KyRhBuOkdf653uEaeK9xBMVx
         9/39xeePhh4nrxFrPplLFAGjUjQ7froB7ni1/nfmVQ6mS4o132/k3/iFIUQUh9cu4pIN
         hykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qzVrB/RqgOjdIY22HEoAP7VYRNeb1JuCU8EtIvftbNM=;
        fh=ac2KN/oMZoMrDfWQaqD/9H0iVWVq5lMURcq5KFHo880=;
        b=iXhsBra75nMtz9eb64NnhIQ53GxBWSE/mbuX6832YxhF9Nuppuc6eTn0DB3VbjLFBD
         t0DJta2tYI7fk6vrmtkMwJ57DiNVqo0fEPb+4c+8PVb8DaltJFzlKU71KnRqOavL8DXh
         pdDizVDpIiFj7jV5emOr5ycmw5kg7k9ERrkUKSaqfNfPfsFebj5s1DkAlwP4SaTUFmPe
         +35Mb4hoXlEm1B1Jq1aH84t2Z4J5nSJNySuzPBxmq4JJj4DPoMRJzFMwUMlSN10yQQb6
         LVhTc7Qo2DjqjeTggvOZb2+EfGoqLpipXZSrmvPdanKwuhcYOKCO7pMp7oCFxKoSm9pP
         ln+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778660172; x=1779264972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qzVrB/RqgOjdIY22HEoAP7VYRNeb1JuCU8EtIvftbNM=;
        b=V7dORv6zAXEFTTiLACvG/Pym3Q5Gw38Y6w7ZzXNaWdY3DvU3xpsfGpOQwa2eHXUven
         Xpaxn8/txeUJuijKm+uPrOrU9i/aQFrBYtlK9zJdWzgsXGA4pd645IbWCEuINJJ2C49K
         gRAUWffXWY09A6yCn2oqP4NM/wMXS795VFVG2eOzO9Ge0HwbqogUtmy1bnsCqbNtkKGa
         XBfQbvoczUx/guPFiPgW4hzXpjiu1NpqsyWQORckcpLm9gzXStaTFLEOD1LoIfYLvnSK
         CUVObDinIXJzKXKP0Nq8qn38kp9g+nW8dIzmSJreTjrDouKM/KxHitz7R8OH+162DxoI
         ojxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778660172; x=1779264972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzVrB/RqgOjdIY22HEoAP7VYRNeb1JuCU8EtIvftbNM=;
        b=ItTh8cr2e0V1hnNpKmoMX8uMa0oIJqk0beEk8yVO2K65sX7pWf6mGiV/7bjroOgFQI
         HrS2RxJGlI31igoIl+TNUxtl8/8CWEtE/iHJyllb4RqsEKGPoILMg0ZUCLfUZd4OAMb+
         Hk95852j3s9eWQVEGcjHZNbyGZWnq6VxpAFbTQsgpABoOh3i5jWeZuma/RQkxyCtXANn
         n1+tXOONkx04sKvm8+upXAjW9hAFXOAaa7A7WqOBUjZpjM9CBOuB+vnA7Imklu9He8FF
         4t62eekJyLkVW9mtMN2k+y7kw0oViAcg47hJLXsnP7tc2qRWML8XAcRX94ekJP4e2oZS
         rYmg==
X-Forwarded-Encrypted: i=1; AFNElJ8REyu1pzMzmqklzkmRQTyaw953Lt9JidIc1OUv/YzdGmLuHofHh08xm6GWaAKjJs0YV0fn6ALzrEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKQyNih5SqQYFOzni3c5d8Tv1h16nJpttjgJCMvoqDkoLDHau7
	Ll5H8ouok3CJ30AjlipTwvHu3+ZysnzgbXQG4QlKKX8As4YZhJWMjXz+sDbdhfYokkDaz7e4ulh
	2hKHXHwr96x3HainGC2BtWtXTZu86WGI=
X-Gm-Gg: Acq92OGO/aswE6CeZHSLRnEuztiwzEmA71+yxLWHjJZ9+u0tEhJbH6TCNgezGJmBhAv
	H6FfPkj1hHZ6P4cYyVhXBJ2JCW358ao/9/R13Zk9A9GfX8JkJZvECi8aB1Tuh66f0bE4UbwQ83w
	plA++xud9rsW4ZyIcct7Tehi3NUQaJNMKeFvoSto5RSWpkP1NivKqUkIzGRKIHeFW4d6GM6Feu5
	h/YquqjL14lrPkClYStO2NOG30wOzBWyH+Tw+1AocetEWd6jbhHUimPEfCZzW2wm6NmQvdsehma
	KzRf8T67vJ2uwcJp1NcVCWaEQD3uIxhtT2e+8h4qZbx9X1czMqNYyWOK9kr3VpbesVPkYsUYRA+
	1lai9r2ehIJrhVURs69n16qy9NE+foBPf8oIJSmkCPPpkQms0bcyfVcuUQAxNOA5cXaYN4AUdf/
	665tmyxg==
X-Received: by 2002:a05:600c:42d3:b0:48f:d1b8:9a86 with SMTP id
 5b1f17b1804b1-48fd1b89e4dmr7097915e9.8.1778660172003; Wed, 13 May 2026
 01:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512223215.25596-1-aldocontelk@gmail.com> <20260512223215.25596-6-aldocontelk@gmail.com>
In-Reply-To: <20260512223215.25596-6-aldocontelk@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 13 May 2026 10:16:01 +0200
X-Gm-Features: AVHnY4ITA3cPcBmpWKvj9-60CMKYwWN7AxI1LLaGuAndemms0NBn3axwcIBQP-k
Message-ID: <CALoEA-zirqmv6Ru0KLDjkaE4iUYaLWCnhC6B0r_w66-oZ==pvg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] iio: light: tcs3472: move standalone return to
 default case
To: Aldo Conte <aldocontelk@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 May 2026 at 00:40, Aldo Conte <aldocontelk@gmail.com> wrote:
>
> Move the trailing 'return -EINVAL' statements at the end of
> tcs3472_read_raw() and tcs3472_write_raw() into explicit default:
> cases inside the respective switch statements.
>
> This removes the need for a separate return statement after the switch.
>
> No functional change.
>
> Suggested-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Aldo Conte <aldocontelk@gmail.com>

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
