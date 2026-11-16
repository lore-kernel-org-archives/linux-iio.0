Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794820449;
	b=T4wzFdmaQVMojatPaMPMldo7LYp6+6B0PfnVTNfSx0/LTLlHhOzPi2M/cYNxXzGeAL/N
	 tgXP7dgDfOE89qbbXxFOysPNBrf/s6mtsdy4olay4VKVDaPkCkRiechnkVqzw1nM5HocW
	 iiFuGDfuco3G3/1RbOK1kMk0TwpHNV97IxjiPE+3WjIzSDtqn3yTzcP67aMipIt+ZDwys
	 Dc9CiVaGOrc1dANP4yWB2VNT+/PBOUvvyc4SL1wJu9sGmfDZp33e8fZKlVUcrdgQ68YMX
	 HkWS7WsCI3J3dX1958dGCA2ar0d9r8jZts+JdXKF5gEwuHTm22CQRm2FDXq7huhWeJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794820449;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-Last-TLS-Session-Version;
	bh=bzhy1DAd5WxrYnCXpRfLON67LvQNVH3MYSk+qm8+vUU=;
	b=tRlJCPW/XBc55LbbayGJB7ktCLxFGi9YNPXHRtUByxM4ifqY3eJ6OQpTvmQrbO3/ecjS
	 4ERS2CQrfpU+px9t44IUiqm48CuH01eT8v3BY6VGzBJXa21lsSe7MgIho6qy1ma5jADcW
	 qWNY39j0PLDTRMZfTbsSUjcQX+gL0AGb/X+89MwOVElOfwBLSZNq/Zr7mnpCihe8rkKsL
	 tc7+IdYr3F/kZpNktgTuj2DIyqymhSGY0cro/8BT26AO3ipuQfeHLgNgZhNYYf8l5krvX
	 IAgFlhCfn/cSbmWcOkvIvCX4QTqfHES0xBiTfNvzrRhyWInEQZHe6l/CAuIXogC5Hiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=S1hPUkUU;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91968606A338;
	Mon, 16 Nov 2026 09:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91968606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=S1hPUkUU
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C63CA4E415F7;
	Mon, 16 Nov 2026 09:14:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 991EE6023F;
	Mon, 16 Nov 2026 09:14:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6F1A911BC084F;
	Mon, 16 Nov 2026 10:13:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794820444; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=bzhy1DAd5WxrYnCXpRfLON67LvQNVH3MYSk+qm8+vUU=;
	b=S1hPUkUUg/VGiq+Qb+ZTVMO7sM7o1NY13dEQpbIVgHbqARTm/qnjvJIHP2Qwj0QuaYxhEq
	I/tD5E2BAB5PVe4KghpbBcbfDShOnJ8C1jXHXYRZkR8RG6+Q62EPbYmqPulFbAHt+QCAnm
	O3o0RAfYjOMbTrIHuH0RwyM3wJR5K3Svin7hMljOLd//vM8FOOKycjLSlb/TlLn6pqG5hw
	MM1QcQ0CTARII28UsvC9Q8DFQmU5zW1RInsVqeS7JV3x6+sXMB+snpGSC8BoT2NofLGJIi
	g9/Z7OeKeQ1iSF6mKsNLEf2UMUtfEEsYNloT9gl2qhKFzIG0yRUHlcoZ0Fj4Lw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,  Nicolas Ferre <nicolas.ferre@microchip.com>,
  Alexandre Belloni <alexandre.belloni@bootlin.com>,  Claudiu Beznea
 <claudiu.beznea@tuxon.dev>,  Song Qiang <songqiang1304521@gmail.com>,
  Radu Sabau <radu.sabau@analog.com>,  Maxwell Doose <maxwell@maxwelld.cc>,
  Tomasz Duszynski <tduszyns@gmail.com>,  Erikas Bitovtas
 <xerikasxx@gmail.com>,  Waqar Hameed <waqar.hameed@axis.com>,  David
 Lechner <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?=
 <nuno.sa@analog.com>,  Andy
 Shevchenko <andy@kernel.org>,  linux-kernel@vger.kernel.org,  Jonathan
 Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [RESEND PATCH 03/14] iio: adc: max1027: poll own trigger from
 interrupt handler
In-Reply-To: <20261109042851.1326940-4-jic23@kernel.org> (Jonathan Cameron's
	message of "Mon, 9 Nov 2026 04:28:40 +0000")
References: <20261109042851.1326940-1-jic23@kernel.org>
	<20261109042851.1326940-4-jic23@kernel.org>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 16 Nov 2026 10:13:57 +0100
Message-ID: <87fqx1t9yi.fsf@bootlin.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 09/11/2026 at 04:28:40 GMT, Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>
> Poll st->trig from max1027_handler() rather than indio_dev->trig. The
> poll is only reached when the buffer is enabled and the device's own
> trigger is in use.
>
> This removes a dependency on the trig field of struct iio_dev, which
> is to become private to the IIO core.
>
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
