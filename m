Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDCA231835
	for <linux-iio@vger.kernel.org>; Sun, 26 Jul 2026 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785059000; cv=none; b=MbwpZ/G5fUxJi4EHkEuTuP1Rqlt5yv2b5JtPJzv2QoWX6cy34eCli3Zm3Sy6w1I6w0sWbsCemD1T2lohVaqP3LJnFhez5cq6P8PKFA77UDf36Crd1F2K/XMziMbaK+G2rWW82+hsgx1Hb5zACe5m5eXcQDkrDQ6dlnkhfEWPVMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785059000; c=relaxed/simple;
	bh=+28w8JULoIxCnVGDuqpEA2z2hoQKFvEf+nNosl1Ye+U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k++GMXms0jLSY2BvmQnOtgX2gx5+O5smYijP3R5u+N5CS7PCq7GV63JLVN8eXdi629G1xWrfZypvh1V8sIW5EoKcILjY2g/pSx3kca38OxsWMF15/hlZbgNHR6NIae3YHSRP/1JTjJ5ZnLVjEp1+LjAmSxdCrvFJPqVD4R7OtNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GYJ7pDU0; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GYJ7pDU0"
Message-ID: <d11e5b35268c4ec044c24c22cbfd816a9072edda.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785058996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+28w8JULoIxCnVGDuqpEA2z2hoQKFvEf+nNosl1Ye+U=;
	b=GYJ7pDU0rv0zrWD9J6EjZjLH/USJGAeJWw9+HOr/LheobIfDunOshjUsggFlWhps8vqPmM
	0olma5PGPWk+U4XLw7AyOtvFXJesYNRjcrvaOK9AyN8it7PGbJfDM+opCgIpOVrHdFm9kC
	dWg2QlOHqiqkBSsAkKgBaGThbZKfRHM=
Subject: Re: [PATCH] iio: pressure: abp2030pa: Remove unreachable return in
 abp2_read_raw()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Siratul Islam <siratul.islam@linux.dev>
To: Babanpreet Singh <bbnpreetsingh@gmail.com>, Jonathan Cameron
	 <jic23@kernel.org>, Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 26 Jul 2026 15:42:55 +0600
In-Reply-To: <20260726072234.7-1-bbnpreetsingh@gmail.com>
References: <20260726072234.7-1-bbnpreetsingh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Sun, 2026-07-26 at 07:22 +0000, Babanpreet Singh wrote:
> In the IIO_CHAN_INFO_RAW case every arm of the inner switch on
> channel->type returns - IIO_PRESSURE and IIO_TEMP return IIO_VAL_INT and
> default returns -EINVAL - so the "return IIO_VAL_INT;" following that
> switch cannot be reached. The sibling IIO_CHAN_INFO_SCALE and
> IIO_CHAN_INFO_OFFSET cases have the same shape and no trailing return,
> so drop it here as well.
>=20
> Found by smatch:
> drivers/iio/pressure/abp2030pa.c:382 abp2_read_raw() warn: ignoring unrea=
chable code.
>=20
> No functional change: the compiler already discarded the statement, and
> the generated object code is identical before and after.
>=20
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
> ---
>=20
LGTM.

Reviewed-by: Siratul Islam <siratul.islam@linux.dev>

--
Best regards,
Sirat
