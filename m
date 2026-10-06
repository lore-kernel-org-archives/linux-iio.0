Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9F242AFB7
	for <linux-iio@vger.kernel.org>; Tue,  6 Oct 2026 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791295376; cv=none; b=YX9E48oOU20A2cHXFt0rqWiYiOObmqxjJQm/SMqSbqnx8fr4D9rlQ6wkLM0HhRs2JznD0YPCUloU1h6oUC0fZJxHOpSwOoDtkbxyJ7l7m6Mv/wrR+X7dOcFZJq/SEVTmToKhoOQurz+PC3Tw/3K0/fEukxRsqhWTocF5n3T0ONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791295376; c=relaxed/simple;
	bh=5FJ+3wqGyca59F2tJp+xdGv8275pCwy3K15hkzXRqdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iH1QsZVcLKQnChgEsmg2M1atQbOyhJyLYfCz7GDJ/o21Vn82s2KspaIfp1cZBiNuOYNH/PSFZVb+hhTBRiHRDOisnpDzKEYqcm/EJsuQE2SOqDCW8gOBvZ5stXht3YzBPhjBWAzrE2fIsAtQ9+hRvGk0mGCdlZsbwruKvG3SISU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l9ywdnOK; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l9ywdnOK"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DAF9B1A114B;
	Tue,  6 Oct 2026 14:02:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A6C2960553;
	Tue,  6 Oct 2026 14:02:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 73DF710330890;
	Tue,  6 Oct 2026 16:02:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791295368; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=M6kf9WIEKxyalB1T8WRSaTSHcfDMs+UGbwv/Xr7lXgw=;
	b=l9ywdnOK6hEiATyjc+PGmPd8P4C8VWmiYxgc1X+KoqTtjxS+DHwofIEApp+/PZACt3e8iZ
	NJykS0rifwtAMHcg2TMvjBOZfe9ITLBw8VZb2Wz92FeIvxuEpU/2ZQyk5uc16HsDZTJRMh
	jaPCjsZhK6zryAt+Ktqx5MUGFaxXSIaSfRJObMiVfkIb0aODnI5UNtfU5JNFwtwD/iF/DE
	6ijeuFsWVrKWvmt2nhRxhieWzx5vWyxnELXXn/fVIXxklIhKtJKfX+g1KQH0WYnyLPd6Nc
	VvF7vekZU8UVku8L6piNz5nqwnZ3IXO1Y0qmHW7PRqZXO+SPnNB+z34g7CzKTw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Puranjay Mohan <puranjay@kernel.org>,  Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>,  Nuno
 =?utf-8?Q?S=C3=A1?=
 <nuno.sa@analog.com>,  Andy Shevchenko <andy@kernel.org>,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  linux-iio@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: ti,tmp117: describe interrupts
 for TMP117
In-Reply-To: <20261005-add-tmp117-notif-v1-1-c6cef6fad64c@bootlin.com> (Thomas
	Bonnefille's message of "Mon, 05 Oct 2026 16:44:19 +0200")
References: <20261005-add-tmp117-notif-v1-0-c6cef6fad64c@bootlin.com>
	<20261005-add-tmp117-notif-v1-1-c6cef6fad64c@bootlin.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 06 Oct 2026 16:02:42 +0200
Message-ID: <871pa3hqpp.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 05/10/2026 at 16:44:19 +02, Thomas Bonnefille <thomas.bonnefille@bootlin=
.com> wrote:

> The TMP117 can send alerts when the temperature crosses a low or high
> limit. This triggers an interrupt on the ALERT pin.
>
> Add the optional interrupts property.
>
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
>  Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml | 9 +++=
++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.=
yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> index 7fb3e68207919..68ee936722ded 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> +++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> @@ -30,6 +30,11 @@ properties:
>    reg:
>      maxItems: 1
>=20=20
> +  interrupts:
> +    description: |

You don't need      ^ this, it's for keeping some kind of
formatting. You have a single line, so you don't care.

Thanks,
Miqu=C3=A8l
