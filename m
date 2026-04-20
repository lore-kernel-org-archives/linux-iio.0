Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A9F3806D6
	for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2026 04:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776659362; cv=none; b=L+aA8pZ3tdb8Q6YG3ncN9TOxoE3bsP73r4RkivPLnLqEILb4j8BCFyeB8O9AY/floQUM5xLq079FZiOg+eEECKeWUkrLBtFsAMXa+UD8zLS9xS9Gj7cPfgNUDZspamsTKvzOfYBJAIfIeuQxKjER4KwI/g7uLsBFiJT9wgOA3QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776659362; c=relaxed/simple;
	bh=SccmvMNkQlBRFcxV7skeaaHf/mnZSiCPSfEcqk4rgeI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=XpG4kwOpmNBCiiRg9R9WV8KkKrdL7WQl7RQqepew2efuQWPr6HeZLoxUH5uS8kqik98l20dUCM7a6d9HCcH/PeZ7HP9Ijs454a28YvNX41dxHBzwP2qMH9rgAvv0bQyT4IuX7a3tXj6spIwOnBruybR1AoMzpvF/rveq6qAjmvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWciCdLC; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWciCdLC"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c7980c060cfso399501a12.2
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 21:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776659360; x=1777264160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SccmvMNkQlBRFcxV7skeaaHf/mnZSiCPSfEcqk4rgeI=;
        b=cWciCdLCiYJKUUl8Ki+5gUskyyX8oKxUPASJlavrbV7/1N7Lr/oOpGyn9ZPhMkwvb/
         qC0/qXdQNP9FFaj//UjRkJ3iq5ShnNqlhrC3TTRpe5HAxbgl5vt34kRZfcpZTW/QlSJV
         4YqOymzNfFZ4R0WgdpOQvUmn5a2IKVudnCMx3rF0f50vJFfLpu7y+OcFqvRGJqUsa6W2
         eYeMiHOceZg+hxKsh83BiyOcOifo0F3QLtLN8EMvQ6+5b5b+hJuc/P+G94ElMpS69+l9
         RVao0fs7WblnHmypXvJy6gjdMrwsnjcktr46suQJ8WrC4077NgM8kswRabwF481r13m1
         f1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776659360; x=1777264160;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SccmvMNkQlBRFcxV7skeaaHf/mnZSiCPSfEcqk4rgeI=;
        b=WGfggF18yXxLPbRnX5PktnPUIJ7hjqeS252bF9AWvlOZSeXq3RWNHi8QUbwnlKjb3J
         9mkLS+zd03nsBP/k9KLF8AYgV0CUMPgZUdEdPkjfvUHujbU9mc8RXYkVdN/Ng/4dWnqz
         mIgSSLxJcgagx0UxIJYvHkPzNGi7OKmCjj1jC3UECk/6H8v6QCZoVkmErJ3L96imCoB/
         4Dz1BF0m+Nh2ETKTRp8Ovhbji2CxgQDgk339nF9CS+f4M3jtZ/g/o1PxGp5fYgIhACv3
         iwjPBkcZj3dpPW+JzZxiIj3Gb8UE80ZQue8/X1kwUjXRWNb3O1nOuuMMJUdQM3o7mPQl
         WVew==
X-Forwarded-Encrypted: i=1; AFNElJ8+yLjGY9PZZI8wflYOdqoYx+pps4aedQTLENIuKPfrcngOfyXA/ivfQu5Zsjk7PbmefZQ2p3mQXHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGw3ZrCkHDBfks+xcnbVuvHyL/7ichkhfw0LNRRIyf2jQPJH8F
	f0e35vyhge4WqscHFL3CPpCLdBrs5+eaQZUfjSrPmgwEdYWvXJzQsBnG
X-Gm-Gg: AeBDiev2M8XbxEBIU9cP86uSxwARMt+dOAU/osmMPKJKpmQ1EcOE8I3gJ0zH8UJdnSH
	NSPe2X5dS9OnWRaK9//+sEFh0NJxwrRQpXOlL4q6hrr2U6UFP0rEhHW5Fj2PdjyhjjpkZuL9oC/
	hT2adVFkbc79RuJxYWMTri5v4PaaxtpOnA7+qrY3XGWUJ/Iq6mJ8EnlnxHsvGQn6eTMOoideKew
	hErv5Bafb/JPPI6R9bnLViXxdDRFveTxU06BSI0ugXkgWRVUoL3boZFh+d5XXDe0EQAjLZuJzYo
	v03QogPuNinJ8PZTUtXoo3377csF1URkt1iPi5aCbiW2h4zZUbuTsJ/apmcNn4X+qXvLPYJ2a7v
	4DJ9b1Lv4BcsqnAKpRC+73cDjiLJAwGnlLWLzeHuofEVIUq8R7bZ4CvvlkeTdPH1vzJgK3A+o65
	YODFLxSRQ+ssGuxSg7DVm3j3cxu1DjmHqTGOmBCrNtqgVQuaAN9maTE6Rq
X-Received: by 2002:a05:6a00:92a7:b0:827:4bca:f1a2 with SMTP id d2e1a72fcca58-82f8c87e27fmr12225881b3a.10.1776659360338;
        Sun, 19 Apr 2026 21:29:20 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:ae51:6985:a95:3211:21d3:390a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ec06cbfsm10653984b3a.58.2026.04.19.21.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 21:29:19 -0700 (PDT)
Date: Mon, 20 Apr 2026 09:59:15 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
CC: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, tglx@kernel.org,
 christophe.jaillet@wanadoo.fr, mingo@kernel.org,
 nabijaczleweli@nabijaczleweli.xyz, kees@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/7] iio: ssp_sensors: cleanup codestyle check
User-Agent: Thunderbird for Android
In-Reply-To: <20260419183310.2a2cec25@jic23-huawei>
References: <20260415050749.3858046-1-sanjayembedded@gmail.com> <20260415050749.3858046-3-sanjayembedded@gmail.com> <ad9XBFb_xCw3mShv@ashevche-desk.local> <20260419183310.2a2cec25@jic23-huawei>
Message-ID: <112AB66C-DF43-4219-9139-2628EBA9B907@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 19 April 2026 11:03:10=E2=80=AFpm IST, Jonathan Cameron <jic23@kernel=
=2Eorg> wrote:
>On Wed, 15 Apr 2026 12:14:44 +0300
>Andy Shevchenko <andriy=2Eshevchenko@intel=2Ecom> wrote:
>
>> On Wed, Apr 15, 2026 at 10:37:44AM +0530, Sanjay Chitroda wrote:
>>=20
>> > Reported by checkpatch:
>> > FILE: drivers/iio/common/ssp_sensors/ssp_spi=2Ec
>> >=20
>> > CHECK: Macro argument '=2E=2E=2E' may be better as '(=2E=2E=2E)'
>> > to avoid precedence issues =20
>>=20
>> Reviewed-by: Andy Shevchenko <andriy=2Eshevchenko@intel=2Ecom>
>>=20
>
>Applied=2E
Thanks, will take care=2E
