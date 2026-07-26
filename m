Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4649367B74
	for <linux-iio@vger.kernel.org>; Sun, 26 Jul 2026 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785091956; cv=none; b=nZdGChjqeUErBWxJpPDprlaRxQ+IU7hjXLR3iY1ruropogwQSMG3mYPGyntVOFQMlRTnfiNvb9odNUEFgss/VQULIApDSBWb5dD8Iu9ZKhyT2BuLIixkhFGEXrDScoEHuOgFD+4alY3Gl9s+LSwnzyFmtOFR/J8DyhQACb6v9No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785091956; c=relaxed/simple;
	bh=f5VsaewYlZt1i8Ky4wjPa72Q5JN1KS3rGI+PD3xWVw8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=sOJrC9iS/sVU+VW3N+DWH1ZN+R8o8X4LLtWFcPaJrC4ZE5ZBdgK8ZUiLy3uy48ZLILgaZZdzYIoMZyw5jYlszo5gFwYuMqnm5om1HdCsz3cetLpLQOHk+MO548xluYeVQGt0xPqVlGgrKP+0SzaG/Ru8aFJ5KySj1ijA+coYPQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kv+ULN+O; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kv+ULN+O"
Date: Mon, 27 Jul 2026 00:52:23 +0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785091952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=whdVcj23Ps7iEgQlji8s+nOuelww4Ms+98cWp5+eqzQ=;
	b=Kv+ULN+OEpd2rRZJctoj5+595vhDdQJj5caG41Bn1/ibhfVHn+de40AFjS4BZoBkEwA7ZM
	2mlH8FY10c6eixu8oHfaQJjOSZQwlDM8JMobI1TEfMQU3mEymsOul+Tai6JKBpZ1RW2raq
	FbnMWgKLQ+8tCJeYP+8cVGX7lsH4ov0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Siratul Islam <siratul.islam@linux.dev>
To: Lukas <lukas.metz@gmx.net>, Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: dac: dac8163: Add driver for DAC8163
In-Reply-To: <amZV_2_dsNZmp7Bb@berta-MS-7693>
References: <20260708-dac8163-work-v2-0-3acd1bf20182@gmx.net> <20260708-dac8163-work-v2-2-3acd1bf20182@gmx.net> <e84c4e047e104cca9b88dda791997ceecba1204c.camel@linux.dev> <amYVZtbxu4fjhBkx@berta-MS-7693> <6b3f1b6188afbb8ebf9576274894b5ed292eca92@linux.dev> <20260726191833.67dcfac2@jic23-huawei> <amZV_2_dsNZmp7Bb@berta-MS-7693>
Message-ID: <1E57F5BA-1864-4644-932D-3612AE7B1AB5@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On July 27, 2026 12:46:23 AM GMT+06:00, Lukas <lukas=2Emetz@gmx=2Enet> wrot=
e:
>On Sun, Jul 26, 2026 at 07:18:33PM +0100, Jonathan Cameron wrote:
>>=20
>> As this has come up, I'd favour just having two static const regmap_con=
fig structures
>> and picking between them=2E  Obviously I haven't checked but I'd guess =
that any
>> overhead of extra text data for those is not that different to the extr=
a code of the current
>> approach=2E  Generally if you can make this sort of thing data rather t=
han code it
>> is a net gain=2E
>>=20
>> Jonathan
>
>I actually misspoke before=2E Since all dacxxx3 devices have different
>default values (mid-scale varies for different resolutions), 4
>different reg_defaults are needed to cover all the devices=2E I could
>define 4 static const regmap_configs and pick between them or go with
>Siratul Islams approach=2E
>
>Best regards
>
>Lukas

If you need 4 of them then it's a bit too much I think=2E I don't know if =
it would be acceptable duplication at that point=2E

--
Best regards,
Sirat

