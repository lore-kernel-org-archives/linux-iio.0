Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793614929;
	b=KF8qcnZKx51sqxdB2kO13krbyMgpsQspbTYhjQzAMk4iN1ByL7PGkb28VfMvhbWW9CT1
	 lxv9se1SKnjyoc8pmQnBYuQNMg5t8YAPq5smBiZ3ouxGojHH9tPL+rkEFritfUHU//81t
	 pfRuxA2lpheDWWothwkHeFMVJImzCFG3YupQltiwCCcFaGN4ZIFhtGn1pLtVsFORjJzGw
	 Zq0LoWAT4CMBfDUqrxVVdru8h0/ps3iHChOJMwGhVu4rMKMJNwIIk956BaBkXpPoW5HE/
	 GRMypl+pe19vOsReLx/Zu3bJ1IFB028Sk3pRnUJYO+pLprHK01krN4jQhNXBOQ7nr2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614929;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5o6UruOZi6/zwSOG7+kN/pu78Fz18zbslujdUGXifOY=;
	b=y1hkOziTnBYr+uWRlJDVV2VOB0f+npFFcPIeUBiN8teqDaXeltqe6U1da/rwMDHqu/LR
	 yvA1yu56Opfv66Ocroj4s1kxQHnL0ysXExBMuI5gAgzmTCuXR8UNGE10ZwyBaiIyNGcOV
	 MO0O7OuhAhUU9fNytx8SW+ZcgWgEo+QxWTntj1JZmsFZLHN+5p5f/GaqDwhIVTzYMoWof
	 lsMld2PWLDYrLOHQ7mq2SoL1gRseER5aXoqG8S6qg9+GMj8d1E2ZKAe68c+4F3AYMQ8lR
	 d4H7sNJDg4u+mE/BctWa8CPWFlEB8+5W9kkQusuIpbrHntRFoCtdJv+7v6DbWTjWCWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VwrQRzgc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26878606A324;
	Mon,  2 Nov 2026 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VwrQRzgc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793614928;
	b=wOBmZY43CPVAQygICy7oTYhHzf2IQLFSdjE1FSQh81gA0xTCD5Fk7G4XuHWWmsKk2kKH
	 XQ1sLEQPLn+AOQVnU+ROWApdvislROmLge0Z2FToZ4DdXIlb0lJyCi5tkMJgHilK61OeA
	 qqQakpy/epth8sBy6pcbYJXq3N5XO5Tn7Q6i2LqbAdiQFrLSobd4AR2FD3WoQlMusJY2o
	 6m0UUBwxNJBXioA2ONbLkgF6ffBPvlG3ecFedg+NdABXOtYwQSYpkXxmF50x5nDN5h96+
	 lCTq28QGgOWVsiUPYeP2GaisAepqimGZKh/HcbNmZHR5SDW3aKbwBfvhJfEkVFMhF7Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793614928;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5o6UruOZi6/zwSOG7+kN/pu78Fz18zbslujdUGXifOY=;
	b=i6JQWJq+9EnCooPjZj1KJKSenfFVs+P94E6yrIFyF5thrLyxMbw50+XiIZ2b2ygTxPYA
	 8EsYs8hjRqNrI6OZN7DZIZQ1SNBsIpeEAuT6DoTxgKXC8vu9IpTsZQcpGMXuz18P/bzyM
	 6YrfX3fSjZV1vv5/2vEMdClZbkQ+Bs9N3vi8YiKWi5gtW3/uUqLcSsDJ3dNCYF5Q66CJb
	 xRNe10CIU17GUQ0eSck/dhS14IEJQIl1J0u0itLQeu7Wb8Ue8pmDBjJxe+7h6cf6weHlX
	 rbqJsZ8K4rwE2UfRiKB/bWDV88DThh7jzYs3Ce175ahvhNGIKwm9CeYA8e/UCxbQ7ag==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 6473C1F000C1;
	Mon,  2 Nov 2026 10:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793614928;
	bh=5o6UruOZi6/zwSOG7+kN/pu78Fz18zbslujdUGXifOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VwrQRzgc2/EicJNoh/OdDlV6W6TxajFnjHE9d1c9n/nm82sHYaTyZLDUs5LR1KyXo
	 totytH+jZ5qIf/vnnzDUId5cFiwF9PF5h7KNs4Z8lSbz6gNunNPQZpwbEIsizGpwAu
	 EgN990jEg5wLQErUZqBPn9BD385oy4/tv53wrnlCFR+WSsxdYVGxL1Rlc4IQ9Ja0r1
	 iXN3FUDO27qGhLAJVSynH/AYq8EHbLw0AYEI+wvKXU7TVzdBg1FlNj/Ue9OsPft0Bm
	 S94MrND8OFDjcyDv0dqh5P+gevGO7uQeam/qud6+sCsa762x/0v4pvgSt8ZzwmXCA8
	 wowXEBvewqmwA==
Date: Mon, 2 Nov 2026 11:21:59 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Jaakko Koivisto <jmatko@utu.fi>
Cc: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] iio: chemical: sgp40: Implement
 execute_self_test-command
Message-ID: <20261102112159.00006ca4@kernel.org>
In-Reply-To: <20261102091258.247402-5-jmatko@utu.fi>
References: <20261102091258.247402-1-jmatko@utu.fi>
	<20261102091258.247402-5-jmatko@utu.fi>
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

On Mon, 2 Nov 2026 11:12:57 +0200
Jaakko Koivisto <jmatko@utu.fi> wrote:

...

>  static const struct iio_chan_spec sgp40_channels[] = {
>  	{
>  		.type = IIO_CONCENTRATION,
> @@ -209,6 +222,47 @@ static int sgp40_get_serial_number(struct sgp40_data *data, u64 *serial_number)
>  	return 0;
>  }
>  
> +static int sgp40_execute_self_test(struct sgp40_data *data)
> +{
> +	int ret;
> +	struct i2c_client *client = data->client;
> +	struct sgp40_tg_measure run_test = { .command = {0x28, 0x0E} };
> +	struct sgp40_self_test_result res;

Reverse xmas tree.

Otherwise LGTM.

-- 
Kind regards,
Joshua Crofts
