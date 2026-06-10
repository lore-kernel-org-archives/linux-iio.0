Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A706935F164
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130345; cv=pass; b=QNyLJeI30m9kD7sjrxKPPOg0EEmavpuUCtk10hRSoqIHNaQAsj8f/gOCiW2L2LjCGPbQsQTK+h4ixPA0DAAbKOQO1jCT1W445a6RjEGR/TsFtqM0DY6dml/vpGY7DYatqI7R+wQyhwQ2l7XSjwQxt5Rj+AJB1elfyVtEV5pfwOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130345; c=relaxed/simple;
	bh=84BV/mwMU1e5gFyzZ0RhJH9dPV/GfG5h0Bh4TFAWkc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCVe3qHHXCggQr3D0qzwtVng4JcYpmffd9zgG9LVm3BjraQAHWUmpsU/Mpbcxb4d9LjiV/SMmLe3bkbaURpQ2mnNqqrCsMtdFRybhbjt6qDF1nMFY6DjWgcuP1qUKL/WR1dcwgBHbmeOxyK0/5QUwVBY1Fq3z2MLg/TbPcSzRao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UP1wMLXk; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UP1wMLXk"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66049669d78so6664158d50.0
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 15:25:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781130344; cv=none;
        d=google.com; s=arc-20240605;
        b=Y18O6ykrTyWWb1gHI9lvJQSHM381Z5MQZk2n2HFxnVhI1bkxY4pnepoP4h4ipp8jop
         eKIs3zcQKAmdUuFFFMqWcNM/KN0yKD0foKOSB2e4bK06BHa5OJwLTXGyOqvIxviX60Oy
         Ya2V5Gt0SOgfAbjXv2lvZzthOiDVUnStl9cD3RlMsrHSDE01mLhmLtx623euYuUN8Gfm
         D9FhkI7PazAnUPKCQPMhE/HtWgvi5Y7TTzoJ6RQa/6QGf3cIcTDjQKGe3Gx2rIO1PRGj
         H7ENSrnYf4jdKQmjuJgR5m67M4sROZy6O0vl8jbbhir/4PRUt4icRD2zwPOyIHl9S8I2
         N7XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=84BV/mwMU1e5gFyzZ0RhJH9dPV/GfG5h0Bh4TFAWkc0=;
        fh=3+Q1jJfr1s2o+IYTPTxZeUQVYHY0QJJgvyKq40S0LqM=;
        b=XS6D30sazlpd91yR17zI/7LoZGUtjxU3sYKuLa8j7tgI74m245c2U5qFxNFlko1j8J
         j3om6jYnKeUQ/eJu840Ta5UK/QIAYcFEO5w7M7UbLt+xjiV7a77MMnragRH62+tBbfZs
         MX8aSYetKNnx3nQOTJmPbrthZ4vBTEJqGOwni6m/H8Vv82kXHbma0T6dCy73EN1+xQ6r
         Z1idlMzgSYwB2FTA/jCWcW51gzIACzmZ7fOtK+Qb2TwxSTOdKBgVkCXZvImzfGeH0qH/
         mHSFKclHvfafi/9wwxoSD2/skkmsIA5RtHt8CLNI4DIwW7VKH/BuHOIUX8aR01VTZl1S
         qKaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781130344; x=1781735144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84BV/mwMU1e5gFyzZ0RhJH9dPV/GfG5h0Bh4TFAWkc0=;
        b=UP1wMLXk1fmtUSjh1b96WXWbotb+rtGHKHRLzUhFimEJ1FHVzsOiSAubESByfS766B
         6q0quP6hUj5wHBpAWO/uhqeTU2AWO5tW4WPGbyw5BvzlzwR3oW8iMTH63AMG8tXe/Bhl
         8IMBgSe5IOZ2QaewwEDtIWJmuJ6dlzy6dfHqcszx8hforUfEuZFKcWWmJQcJP9DEM1Ie
         6RonfrzjxfekSPye4aEWYsZcAi1AslvNURSIgcevKdwL07Eks4QQPO/8/mRjJ23MwNpp
         QVOjAMNXdai2V2lfuxVMbsE0+kiJ1AbJ7kpgo9NlcV2xkbmUDm5R34602HAWpBBMFvKq
         xEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781130344; x=1781735144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=84BV/mwMU1e5gFyzZ0RhJH9dPV/GfG5h0Bh4TFAWkc0=;
        b=jfV0DVA5VeFGNQX9Sqj9os0LjKbk7HvCxW8RCYpNIb42lFNoloFJa5wsMvJaWqycVj
         eVtcaQu9PFkvGWL33biU1PpvrmWXpJW0xLaf38wEtq1DUU8odaZVIpX0t/GIJrRvyohv
         xEQPU13KwO5vBGA36FK1UrZN4Jazo+plQVL1W4H8cphR6/ncLwHYdwzIIF6UZsrDnoUK
         DRxnKnKwf2Mlpe+owxLOh8mzzxEDfU4rIYIhf6SupSnKZ5gZBSooe99gKKCKk6IYnKwe
         k6Pfk4Hd2GoeZxskb5Nc5T7+m+bfS7fniCPG7TABuT5R5YzAdamKY8Lf/ppEa+Ssp3tR
         Mv9g==
X-Forwarded-Encrypted: i=1; AFNElJ9CcUuQfEoyAKWQrMdM+PYf4Oj7WsgsaweYdScPZMgKTPywdcthhY9KfubByUzJB1ZAzafaIutLZXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIukY4EebpAJRIAF4oOPqmJhbgZaq2pyquzWTKcuJhHOaZtsvk
	GwP/PBzqNKQQtkDY4GV9JKsaAqHRcC5n3w3ANtIjM8HCcu+MWPTZftmuaomKmDRHPZuTTt09GV1
	ZnmSlqxcbLjtAPPKPX9+IRtTJXQVOu3E=
X-Gm-Gg: Acq92OE5SXvDkpwQiWVFz5+dFUXy7xafxQNekve98fzVcI6ef4Yuu3nhcknhwBE23XM
	vkoPtwHHy+lcXDeUMlQCq7I2TPF5HTwacj7b/tEhJx0oBx5FEQ2c9cU0yB3GYf+4qYxIHSflDRn
	HzfeXio6EBJIBVyCqM7Eg7dsR3CaNCJV/1hFsh+TerSB8GI0t2BAEOolqIgrwo1nLA+mdNwkboe
	YYZrXXY+4uMJGH9gG/BOvmXLl7vXwRUy7yZNqtSk3q3fA7YATnz3YOnLg1gC33pn9GiziZX8PPj
	K/I91Bsj0ZxKnaY=
X-Received: by 2002:a05:690e:488c:10b0:660:8e61:1a49 with SMTP id
 956f58d0204a3-6626586508dmr1038060d50.18.1781130343683; Wed, 10 Jun 2026
 15:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609161701.52513-2-m32285159@gmail.com> <20260609161701.52513-4-m32285159@gmail.com>
 <20260610-turquoise-marmot-of-research-c3c51c@quoll>
In-Reply-To: <20260610-turquoise-marmot-of-research-c3c51c@quoll>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 10 Jun 2026 17:25:31 -0500
X-Gm-Features: AVVi8CdMYLBI0tFUeZZLTv33zNModoYgKYUA0hqQWE3zfzu9UxvulxK2OuvGpMc
Message-ID: <CAKqfh0HRjajJ9v1jeyTx=nJF4FUCnW_B2v91RukDEcXP3LmRsg@mail.gmail.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Add myself as maintainer for SPS30
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Tomasz Duszynski <tduszyns@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 4:10=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Jun 09, 2026 at 11:17:01AM -0500, Maxwell Doose wrote:
> > Tomasz's entry is no longer valid, as he is not active anymore. Add
> > myself as maintainer of the SPS30 to replace his entry.
>
> Same comments.
>

See response on pms7003 patch.
