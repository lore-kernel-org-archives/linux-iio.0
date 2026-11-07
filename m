Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018322;
	b=Oz0PQkFiCGGlLp0mKcH7xhNwowE8XJ5dHuQ962U4F6kcEjMt63lv32hL6liula69p4/O
	 szG/RfEwtUmmL/qOpEvZvab6ONLcwxw5g96N2U7KUeWn0V4wMndP8q2qcpeYCcgeJlN63
	 Mix+JDMndiHyuhNBuaizkSObJgD/oS1Ih7YZCwoRtJ5/m0cuyU8r20aX108+6jq8OKxuP
	 TtYzqR0kNqg00evLTWo0vBvpMQiUwabqrqn3WZpblaU+R4WgZpQAJOGUacalcsHbDzipt
	 AGAIA4kQ5GAjqLZ1oizsU5wbRBiQ9GH2naWRGaK65GVGXpMIWuX51kk6pDkbMSetKjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018322;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8dwzbbG0d+Dc0ujJeoG+sfPZys6ay5RFi/wRU64dNww=;
	b=oK1JRfbn+pfvuyFWEU9ic8By7oxzv0VeyfPcB+bx+xcgL+sqTSk0zycq+eR5+Lbqhb8T
	 MQocnUd9+eLZ5eBvCzOJpIxTM+oj5d77wiQJLZ5dSI9bkO9KOBasxmqbW/MscqyXVhYu6
	 Qk/ynqFSFbqHxQNMvKKxTUF6RXbJINDzr/E+THxYCVVyIflYpBP1TGuulFnUsBkctZGT/
	 Jjl0t3NUYl2ZXfX4lcLqbQEn6Hk/GsYiy5FEnma+Adeg8UfkW5/QvMO8f7pApZy2anSR6
	 TxUICXoiESpG1UqmKERnCxzJ3DYmgAXPgagmxSzW0qZ/PORTNTpZ1umqr8LJ6LNjXzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kX85Bmqt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E23606A326;
	Sat,  7 Nov 2026 02:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kX85Bmqt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A10F1F0089F;
	Sat,  7 Nov 2026 02:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794018321;
	bh=8dwzbbG0d+Dc0ujJeoG+sfPZys6ay5RFi/wRU64dNww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kX85BmqtvNJOuadn4MDncRuCYGKMhKsDBCGD0KmZZWNEIULZPLALTrCZRqx5jhM2d
	 WLVFnh9sPFGxfYB/VqZ8y7zG+8zz1BNPJwwWrUZe9icrcGTCfj6ZgHNfgc3hJDW+pq
	 bYoJ8wMcTO/1TxGTdIMtIRzbDczUnZEuqN/Rjur3zY71/XnA3a935UCUCBZNFpANwS
	 oQMWRlMoWhh4+KTT5QXuF1SzFRxz7rSUHF0FSDmjSUlkiZuqPe7/vNlFC6Syh8AYTn
	 D3tIW6O2QfkL2kKYHCeeWzzzRXZDqOEX0J0yTU96FiO44JpJKzcVQghqEZqWVkNThh
	 SFr4Und0NCobA==
Date: Sat, 7 Nov 2026 02:25:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Christoph Rudorff <chris@rudorff.com>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, Krzysztof
 Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/3] MSM8916: improve gp2ap002 proximity sensor
Message-ID: <20261107022513.3c729034@jic23-hlaptop>
In-Reply-To: <20261106-iio-light-gp2ap002-v5-0-070631a7252c@rudorff.com>
References: <20261106-iio-light-gp2ap002-v5-0-070631a7252c@rudorff.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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

On Fri, 06 Nov 2026 10:33:25 +0100
Christoph Rudorff <chris@rudorff.com> wrote:

> Samsung J5 is equipped with GP2AP002 proximity sensor.
> Unfortunally the driver wasn't working, no irq received.

Looks to me like you've addressed all the feedback and generally
looks good. So applied to the testing branch of iio.git.

I'll push that out for linux-next to pick up sometime next
week.

thanks,

Jonathan
