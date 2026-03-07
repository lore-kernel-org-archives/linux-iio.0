Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB822D3225;
	Sat,  7 Mar 2026 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772883215; cv=none; b=VQi00QDRtOEjQRyC3kaI+RJt6v0zBSiTNGZt4RWBStMcpYvVefXmhTYsv/qsIk5xZsKrYNO/SnKBTxXRxqrhvZqK8XN5fWS820qSuY1uA9Pw/+RkCBZ0NIJ/VqextJWYpoAikBZ+jKJplQHkToyuStho0x11qLN6aQizL+ND5ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772883215; c=relaxed/simple;
	bh=6kK6ntpO+ZkJ4hHqzVXw2tOwyQlx0tRrgZ15DXyokLE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UfTatq7f+l8MsMMtRSKnY3221H/oMiS8+9QMgVqGw1YAAlneN3H33YhyqB4nYIu4DzpH8NSbN1j79DZWaqNNN761hzp9MMrby0IvlEH2j/zGowwsnrYt8I7GCnyxxYHtWxWgL7mdx7PirjHEF8RJ48R0QlK0K1967GuWO6GXaCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkX6nc7R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkX6nc7R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA2AC19422;
	Sat,  7 Mar 2026 11:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772883215;
	bh=6kK6ntpO+ZkJ4hHqzVXw2tOwyQlx0tRrgZ15DXyokLE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SkX6nc7R9uI/dOamdcomnE0gCvizrBk/RaxI59uc/F6z6jEjBCWGUVfQbyhWVSK7m
	 AdgNe9vhpw+rTyycE3HgAUqXWXlrLBOKG7ybSUchq7i9+/IawHzpubKlsxj03KYTIY
	 Ehcc0obOOxkbNn4mMJ+I6aSMSD5GsZAqBp65GvKy9gdBOjFLNZJiI7z32HwS3zf4wZ
	 gkNoMaVYfpj/bYs6ipIleitllIljJq3N83pIWu5+LivBX9rcu08x3lS/2zF+foEAvJ
	 ys+LAB+aThmnf4Q6uVLTTItGZOvroUTHKzpgBCbY8Z+GM/cNwcg6NBcpm1I74wOiFE
	 UGQ51t+JjSv/Q==
Date: Sat, 7 Mar 2026 11:33:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Michael Harris <michaelharriscode@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] staging: iio: adt7316: convert magic numbers to
 BIT_U32() or GENMASK_U32()
Message-ID: <20260307113325.73ee87d3@jic23-huawei>
In-Reply-To: <20260305-adt7316-correct-macros-v2-4-3702e3841c42@gmail.com>
References: <20260305-adt7316-correct-macros-v2-0-3702e3841c42@gmail.com>
	<20260305-adt7316-correct-macros-v2-4-3702e3841c42@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Mar 2026 23:17:01 -0800
Michael Harris <michaelharriscode@gmail.com> wrote:

> Improve readability by converting raw hex macros to use BIT_U32() or
> GENMASK_U32() instead.
> 
> Signed-off-by: Michael Harris <michaelharriscode@gmail.com>
> ---

Ah. I should have read on.  Fine to have the patch doing the rest separate.
Maybe a forwards reference from the earlier patch description might make
it more obvious that you've just delayed them.


Same thing on using GENMASK_U8() applies here.

Thanks,

Jonathan


