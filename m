Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B4F405C4C;
	Sat, 16 May 2026 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778929498; cv=none; b=YD+BjzXNLCPcMLeZsUjBQ2n+Mk2qBMChBtas6FVij238FO4WhHWnahtnbZVXhQzzUl+iFnl+AbNG5ZXsFA0aElE6Pj/deAySmWmNKkcjf/RNmwje2p7lc04RTPH78mr2M5d1Aby3VCuuRp9pY88NMcNkuazGDsSH+c0vCJJuuVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778929498; c=relaxed/simple;
	bh=7omPZLl/G5I4I6kCgJ4jz5OWVs3gNyBrazuYk2cT5kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQssaq2oVQlcDsxvxqttGqtBOzRCwMVzqZs8RgAGE1uep53rl6LtdHK78DMFfckOcSxsd4vWvdk6iudoL/CyC5hZMMh6lfxMkbyeTkR1IsvDM7xpdWlYN+TMWAO4xs51av75XrMYHhguMfnAclBK/0AwiWyykvfYusPucZvWTAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSEai6fU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSEai6fU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB20C2BCB3;
	Sat, 16 May 2026 11:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778929498;
	bh=7omPZLl/G5I4I6kCgJ4jz5OWVs3gNyBrazuYk2cT5kQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YSEai6fU7CKvCqJO5Pn7N5oBgCdN93xLqnBAaSZsP5L0gYi4N8ZXRNq1thzXtHEex
	 zAFBMpiPYwu1y6yNzfkQF9myzJBfHFGSDxtY8uLkedrl81URHkDk4+biLGDPA4F2hy
	 BWLVWdmslC1WFQitAi6n68pfnrVH5iYPLiSKtFOXNv/eHN747MVtUghSqP9CTCooh7
	 +SLd2QpaxkdeQ3cfo45fWLqavecSUwzBuo/5J+o1+c/BaIzNbwVNPyFKkVNww5+70j
	 8SPGAQQN/rPj9tiGWAFpmwolnOIIz0VgOJVx9fHxohgFqj7zqBSoRT1YkCk0HQ+wvQ
	 Tp7oxedui2h4w==
Date: Sat, 16 May 2026 12:04:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: iio: make ADXL Y-axis calibbias
 description consistent
Message-ID: <20260516120450.0133b404@jic23-huawei>
In-Reply-To: <20260513100752.8559-1-sozdayvek@gmail.com>
References: <20260513100752.8559-1-sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 15:07:52 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> The Y-axis calibbias rows in adxl345.rst, adxl313.rst and adxl380.rst
> use a different wording than the matching X-axis and Z-axis rows in
> the same tables: the X/Z rows say "Calibration offset for the
> X/Z-axis accelerometer channel." while the Y row says "Y-axis (or
> y-axis) acceleration offset correction".
> 
> Make the Y-axis row match the other two so each driver's sysfs
> table has consistent capitalisation and wording.
> 
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
It is rather odd that line ended up very different to the others!

Applied.

Thanks,

Jonathan
