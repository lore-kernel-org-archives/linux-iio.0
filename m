Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C38430CEE
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213184; cv=none; b=XJoNfqxtOPpoufMxjdfanbkvvAM5aHwGhOQA6K2eo9tW85OfX0GnsIPUyIOoiR7D1GphgSPvRPUF7GJY+r9v2xOjbr0U14BPWK3lpAZEImq8Mn93c3j6ZjTPvmdIh4BB7u0Xc1I1o526j+SfZ289D0MYfRX+JO26UV8wF20RNAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213184; c=relaxed/simple;
	bh=v86wSwgrMuQBTbiZAMKuncJJPs8XClCe0ciN2/0afT0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=PwB+tQY1S7tgzxithj7WjS0c8HA3lK7mSo6ZKqFAxVvCrMjxoeMKsIqJRmd5JC83t6Yl5i7NM91QZkiSR4RO4+gNjgsKbzRRao0adpjEa0FNbLlQ3XbRkMIAEyG8ZFGKdT1bJTgIM9M44/zDVG1m4jgnjk8HjTBtxlCByNVtsFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ty9yFpxR; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ty9yFpxR"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784213165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v86wSwgrMuQBTbiZAMKuncJJPs8XClCe0ciN2/0afT0=;
	b=Ty9yFpxRlmRz+GRI/PEkfJd9i/EtFOj7UBzAzq71sI91KDGgOAELqpEo879a4DPl+m6NYL
	y+ZtGtQdWFnUXs2o673jRy+fVdip8WF6cTD0NtK52Fv5BrYWEDNse5KK6xuclELGWmJxmU
	NNNpdIAR42t3RbgSFKz+t7g9f7diTvQ=
Date: Thu, 16 Jul 2026 14:45:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Siratul Islam" <siratul.islam@linux.dev>
Message-ID: <bfe7d761f94fdd343a6ba5dfbfeccb724f74a87f@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 2/2] iio: magnetometer: add support for QST QMC6308
To: "Jorijn van der Graaf" <jorijnvdgraaf@catcrafts.net>, "Jonathan Cameron"
 <jic23@kernel.org>
Cc: "Jorijn van der Graaf" <jorijnvdgraaf@catcrafts.net>, "David Lechner"
 <dlechner@baylibre.com>, "=?utf-8?B?TnVubyBTw6E=?=" <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Luca Weiss" <luca.weiss@fairphone.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260716141837.83326-1-jorijnvdgraaf@catcrafts.net>
References: <20260714202842.340293-1-jorijnvdgraaf@catcrafts.net>
 <20260714202842.340293-3-jorijnvdgraaf@catcrafts.net>
 <d7fffbeacc77c3135564f902c41f19a219ddce75.camel@linux.dev>
 <20260716141837.83326-1-jorijnvdgraaf@catcrafts.net>
X-Migadu-Flow: FLOW_OUT

July 16, 2026 at 8:18 PM, "Jorijn van der Graaf" <jorijnvdgraaf@catcrafts=
.net mailto:jorijnvdgraaf@catcrafts.net?to=3D%22Jorijn%20van%20der%20Graa=
f%22%20%3Cjorijnvdgraaf%40catcrafts.net%3E > wrote:


>=20
>=20Hi Sirat,
...
>=20
>=20>=20
>=20> Use reverse x-mas tree order.
> >=20
>=20The natural initializer order is fixed by the dependencies here (map
> comes from data, dev from map), so reverse xmas tree would need the
> assignments split from the declarations; I'd rather keep them
> together.
Yep. Of course. That was a dumb suggestion. Should rely less on my patter=
n=20
recognition.=20Though, you are only using "*map" it twice in that functio=
n, so I'm not sure
if extracting it into a variable is worth it. Specially considering it ma=
kes the declarations
look ugly.

That said, I have opinions about your other replies, but I'm a bit busy n=
ow so
I'll get back to them later.
>=20
...
>=20
> Thanks,
> Jorijn
>
--
Best regards,
Sirat
