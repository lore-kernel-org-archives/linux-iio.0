Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794215735;
	b=kQW6N1Ymxvai9oBpra/s7t4uEULg9KGA+xyYnQc0wQadSlYNlpQ5tbYfNadjeEj/slhZ
	 /enH6AqW7wmwk6kWspDiMaN0sqg1+9PGJAYs6gnHhNglj1GUF8NaYFh4nTCbbtjI6i+60
	 ar5pcJbb/So/t2bLllacLxnuTIEHgpGLQakjO/7lU2FWV4y6nFAOUtYSOiMJi7lc97q/j
	 tW4FnN0Dh/jpogalLR8WfkCnVMHxriO7PXN32WYhZUh5RnaWnUeDvIrWewWuqiHh0oFA/
	 suhrzIe2RDezEQsDwlPOHoWgxKmitFffUiv8k3pwNgnStumgC5BysYfLSnnYdiQYQ8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215735;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6Jxa9zmBNngX04KUHpP3i3yWBurR9dFeJjzlLzsw8C8=;
	b=CVas0RZqZ44UwPfODRZhnoU5qhj8+7a6yuFKFCjXSrFTy0YGTJEee5TNNDiAyY87GUQq
	 bqWriEMpqDSICsGE7DLsGcy0rHpCd5HoeLq5jpSvh9SX3Ja80fKG3eLz7uxlmSoX1I0Zl
	 DKE/isL6uaWSML6+hG1WWqcZSouMrkKl0DvbWgqYvTFGrXmWpYIf2t2+t6t8HckzFclfk
	 LZs5Pqc3+QpSp1ON9dBN3E8Xg4Xmj7Amq6mdWKrNuITG4rw8THL3kKVJdGjKxBnst8MqO
	 5iDdYlpWcS8Ha3rkV3fLNuRxWe9e3WwrUpfKN5Wph6+yCJO9cwOtKnhwI44XvTs5qcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Kc/yUXks";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314DE606D803;
	Mon,  9 Nov 2026 09:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kc/yUXks
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794215735;
	b=qy+60FY7SAQVKjDUvY7ss/EiD2GrCBvtl8cB61fGA5+jXAb/5vdUpNS6HwD+r+lHnuu1
	 vbZ+fPXVDl+X7h/d6vWbI+uouQx0h9iDmF9MoZfWAOxL1aq0dCZc78dC2KKSh5X2ZuY79
	 zSlJcsdxKhkL8ci8ouZeJM9RXywd/GRV/eQ5FHZuXmN+ZMNsicMu513fi4/HUHSOZ52DP
	 vh+gjPhtlfbD7Rx4XNELNSzwv8/mYLin+Xoc9s+ny6LGOO3gdJoJnYMpkukSktVEfMU4T
	 +U9gc6BUDnfLrba6y9+bZ9Sn/hZP4tHG90Ts8EwCOIqEq+e1Vy5z0z9rolCEX+fICJw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794215735;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6Jxa9zmBNngX04KUHpP3i3yWBurR9dFeJjzlLzsw8C8=;
	b=IOH250LBsf30dHeqUHyphihaxFA2SykFvAXQ676P02UT+PlFrlI/uZtcAs43w9+H0g3Y
	 WC4+WQWV+PSNVmSWia9uO7QUNo7luLykRPKZmACos89hPPnRk3bntX1D3wA6YV0i2CYFc
	 hY3c22g0OaKOCuuBRmUDdlzaqWeQEBy5vNWbxinTcz7VipnwkmkN3DBKkIDt2aE16LB7y
	 W7ucr5qdzww4/+fH3BuCiENZcmirlgDeJlZTw/3xFc6CNmt3HE/d8uG8x7DWhwdbJ5yYG
	 SwXRGD7KmbT7XAkc1D5INoumi+N2XU+GwhxCfgC30Abxn468CImWyNKTbbdHU4nbSfg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 06AAD1F0089F;
	Mon,  9 Nov 2026 09:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794215734;
	bh=6Jxa9zmBNngX04KUHpP3i3yWBurR9dFeJjzlLzsw8C8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Kc/yUXksMiJzCnYZKIeUaI92iMS40EC5mVipgUcbfrXsfXmEssvuZfbpswYRBEDtS
	 WwMqTw5CDwJzg8s0b9yza1ZT0h+Pwrs6+gSLUqfLJL1SY7yT2xjXMkamY1yXip2KsA
	 B6zjRlbOVMr1k7uR2whcBtk7ERrjpWozXfmKbARdc2sJKNyeYJKlyo4xGvMuaiKpSj
	 9MuZKJ1F24aW/alom3HB66+x8RHYuqZla+ifvs/kJBUtu8XU0Qe/QxezdGxdyHTi3E
	 NuD/mq/wU2VGBmS0UgyGFmQAcBdtp9vaqckO4PwCd23GjHcfFL7k00v4A/drLbRsp0
	 1EvxjfICDx6EA==
Date: Mon, 9 Nov 2026 10:15:25 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Song Qiang <songqiang1304521@gmail.com>, Radu Sabau
 <radu.sabau@analog.com>, Maxwell Doose <maxwell@maxwelld.cc>, Tomasz
 Duszynski <tduszyns@gmail.com>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Waqar Hameed <waqar.hameed@axis.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, Jonathan
 Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [RESEND PATCH 00/14] IIO: Ensure iio_trigger_poll() is of the
 device owned trigger.
Message-ID: <20261109101525.0000640c@kernel.org>
In-Reply-To: <20261109042851.1326940-1-jic23@kernel.org>
References: <20261109042851.1326940-1-jic23@kernel.org>
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

On Mon,  9 Nov 2026 04:28:37 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
> Resend due to wrong linux-iio email address. Sorry for the noise!
> 
> LLM used to help pull this fairly straight forward series together.
> 
> The primary aim here is to ensure a clean layering between the two sides
> of the trigger / pollfunc (push to buffers) divide.  The caller of
> iio_trigger_poll() and iio_trigger_poll_nested() should be using data
> relevant to the trigger, not iio_dev->trig which is the
> current_trigger for the device. Most drivers got this layering right,
> but not this set!
> 
> This is also step 1 in a plan to make iio_dev->trig opaque allowing
> more control of how it is assigned and avoiding traps around lifetimes.
> 
> Includes one precursor fix that has been broken long enough I think
> we can just merge it via the slow path along with the rest of these.

Patch 3 doesn't apply on iio/togreg (I see you're missing a base commit).

I only have a few pahole nits, otherwise LGTM.

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
