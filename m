Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794216347;
	b=Kk0knY2VPMYmAxFeS522dDRcVQM5r93Q8ORcehM8p6PaASkEH1127Ig+nrgwv9AD469B
	 3kAKyYmtUcFk4EwMlw3HkUTRzbDDpK21UiIIdriZ6l6F4GoULmBTDxA8Hw/TM8p7RdmwK
	 RGff3M7yeSXSuPJh29CWSsZFOsn8WDAmWUgcs3QnfFz7VibU6LPtMwXxUZo3xK7G6sYGN
	 nWkDw3X9c9rVSwQRjVLgjOJo1C9gUGjgZS+eac6Im5C+B4o1WLfr/OTwZifnACIszxb6j
	 B4opCH74yS8Uj9x4JuywySIaVKulNfqWje0bln6Ax8964jTxHXF83RyesCruPud2x9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216347;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Y/5uDKm8Gk/asHC1Oh23UdShAn1rIG2NioBbNbUmrKc=;
	b=2gY2FftIMm3RtjYQlkbYkAUn2O6sgQMbhh92wBHr4P13a08xXlZwjLTNwhRDTY64ohAd
	 r0PUXyrrNWbu91sTsiE6qOxh2tTe1UvJTuAvhCs8oA79/dwTO2jOX4LgaIvF6yEKTLmhI
	 G4AVuhhl9MPdNsw0nRIGkUCcRs4AjRhijf1tYVMABk0HqWsKWqWcXr6A8DFC/ubFddYfl
	 AqRskBithOqryN9Nan6J5T/5XTuJ15yaKjMRUgZbahHXPjo0gVksRY6wEf1XtoKfQe6m9
	 oMCUkq2Wic67RBXX9nDLh4KCNP3Bs9wirMMfIm/1Ih2EVDZnZXygQPrvPxlmzOraIeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AoROOLYE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4866F606D806;
	Mon,  9 Nov 2026 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AoROOLYE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794216346;
	b=Jw3M9Ul+ilgvNp9dirDWwKQpchRAaE11pqfhjPvs107c75H1d+FgECzMdpmHrSMJPLrD
	 HJFDoFhb4AnW6OwTfHS/rC7BbvPrEfM5H/+A09YPzO/ExFFlBCN9VSj032yyY8rSdZHMo
	 kqSUuD3WaC150BcXmGlXZaSflbSOOZuhh8lVd/H/Zu+GUBPbPRuDog7z7vTB6Gaiwp2qs
	 zxhTCz+4DFRWOAXBLXHKuQKh27IRicpUmSPb1XfUoCgymkeWmdtjLwi/kk1sTUnRzdnvO
	 Q89EM9KlS+GL1cQDDP/aCcXb8uqagrZoVf1wXgmnnc4rHiFi2RUrPXSCMwSvB9QsukQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794216346;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Y/5uDKm8Gk/asHC1Oh23UdShAn1rIG2NioBbNbUmrKc=;
	b=3pQQFFpxZbQH/4Jgw2TAG7U6b2d1gWunW5W7yW7BXXf9cnjDbr/pPuCOHRSfuT5fLfeA
	 vHuYryatPx8qJHDGUwhc1muAGQx0gSUdLuAK/be/ybKHtZNMgGbVTLeQEtASh4Rd6XZ66
	 RGCvvKhxg1W5zVIIKLOmqWBxva9Nttp8JoT+5co8LA4R7+RfLGeJfe88C5xznnWpEUCWj
	 asDqJCn8tJkVKEMQ81SFxjwzoTTMv95UExoC4Vt+SklJgOTnkAs7w1jUGRyVyqCeU1oEK
	 MBOxMQepyp9r6IEOKMSCU2c+awJfCYEHXDyWvITxsOFKQEWyIk/FNxPo6SeoiWZdZdg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 4E9B71F008A3;
	Mon,  9 Nov 2026 09:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794216346;
	bh=Y/5uDKm8Gk/asHC1Oh23UdShAn1rIG2NioBbNbUmrKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AoROOLYEhDU0IduEsRTwpV6i8xKJN+4LXBKxzRz8d85z9o2vTKsjRXQQnvckunRRt
	 iagn+2BiL/Z2VmKBD49X9L55+Vq73k48GyekknZQXzUCd2OWzqGdD/pjRJWMPEZLKt
	 NE4qNeuWN0RwYm54twvA0Q3TU4Tozsvqx33sT+fvTW+ZjbSTnGSxK7bxOnxFxnrJn2
	 5evJgV0+RuI4Xzxx9h8Tk2Ac5EZaPusRvYgK4R5Y0OhLlp/ADlMWmydnKrPF8UEagM
	 T23vfCFqTfOHXJXeQCHTD8mI/61J2WomycadDIQUOK9dlw2raN5eGMtmlXnOeXEBi/
	 iP45Mu9eLnkrA==
Date: Mon, 9 Nov 2026 10:25:39 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: light: gp2ap020a00f: Add GP2AP030A00F
 support
Message-ID: <20261109102539.0000674f@kernel.org>
In-Reply-To: <20261108-gp2ap030-v2-5-24eaa1b9fe59@kernel.org>
References: <20261108-gp2ap030-v2-0-24eaa1b9fe59@kernel.org>
	<20261108-gp2ap030-v2-5-24eaa1b9fe59@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 08 Nov 2026 22:44:03 +0100
Linus Walleij <linusw@kernel.org> wrote:

...

>  static const struct iio_info gp2ap020a00f_info = {
> @@ -1450,6 +1540,9 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
>  		goto error_regulator_disable;
>  	}
>  
> +	if (!data->chip_info->has_als_auto)
> +		fsleep(1000);

Maybe a comment on why 1000 specifically (datasheet reference etc.).

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
