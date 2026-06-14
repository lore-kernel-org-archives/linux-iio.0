Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC75C382392;
	Sun, 14 Jun 2026 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781443545; cv=none; b=bi7MeJAosK7y1PQ0rPW8K31lS0AG6p6c1ZoKn0Ua2BEGX63S5MrGgr5iqYCFEXyrsthBwwXBQPUiONusq/v+J7OQv3hbDuh4PXanxrLGCMbPxi/DM7QwdmfMISW0iOv8JjGZYqH8nWHofCJcKbrUoL2MewIpWR/WfjvAmrmwuK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781443545; c=relaxed/simple;
	bh=17rcRnx+hxQnBQN38i3zA7IYnkJ9sC1D14von2ZlJ88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9IRr526MEZKgTJTT1j/HA3iGr2YWOBkvm2GqR2c3Y0yTcsLdVwmElQdOKValgudAydvjQQcdUOWfqb7UtG9Y7Cg9yoNJ9w9bSOhOH0T/e1DlL6uoj+evRFu4EPEVV2qpQ3pT1gatBcAlXyO3leOB+jOeImnoeFjzhl2hJrC4QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OT6YQz9s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OT6YQz9s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555281F000E9;
	Sun, 14 Jun 2026 13:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781443544;
	bh=iYrRRn1xMd0J3we/IlJg2+f/wmh/5hqaDhDyq9XF90w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OT6YQz9szyrWOthquDsAL1NjHCV6vGbKo8Hlhysjt15CDAC3KKG2KAyHuoJUD6aGL
	 2i47j66K52Z1AJboaPXEZMYptw3dYuQYRqWHeRVaLznS8jd/+Ppl9GDhnhZzO/4f3D
	 Ql+DkABXHuwc/W7tyzEE5SKovozfcWZsPOGYq4H2BezCjaJSpAG2zvq7hoT9SL36ZL
	 fmBeo7siXVnVBdELSR/HajwjQINwwVKpk/6t4YoKm2CuY7LxXID2rZWSO21sWL+7PB
	 f2XeDGfMAfQ0YYzMzUr96iVIb96n6ZFYPALv1sx+3gIZXBC2uGB+hbyLq/+XDkVSX3
	 XPKg4IpsVC7IA==
Date: Sun, 14 Jun 2026 14:25:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Biren Pandya <birenpandya@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] iio: light: gp2ap002: fix runtime PM leak on
 read error
Message-ID: <20260614142536.48859ed4@jic23-huawei>
In-Reply-To: <20260614071549.81920-5-birenpandya@gmail.com>
References: <20260614071549.81920-1-birenpandya@gmail.com>
	<20260614071549.81920-5-birenpandya@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Jun 2026 12:45:49 +0530
Biren Pandya <birenpandya@gmail.com> wrote:

> gp2ap002_read_raw() calls pm_runtime_get_sync() before reading the
> lux value, but if gp2ap002_get_lux() fails, it returns directly. This
> skips the pm_runtime_put_autosuspend() call at the "out" label,
> permanently leaking a runtime PM reference and preventing the device
> from autosuspending.
> 
> Replace the direct return with a "goto out" to ensure the reference
> is properly dropped on the error path.
> 
> Signed-off-by: Biren Pandya <birenpandya@gmail.com>

Similar to patch one this would benefit from a follow up cleanup to
make use of the ACQUIRE macros.

This is good though, so applied to the fixes-togreg branch of iio.git
and marked for stable.

Thanks

Jonathan


> ---
>  drivers/iio/light/gp2ap002.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
> index a0d8a58f2704..886accf5e859 100644
> --- a/drivers/iio/light/gp2ap002.c
> +++ b/drivers/iio/light/gp2ap002.c
> @@ -258,7 +258,7 @@ static int gp2ap002_read_raw(struct iio_dev *indio_dev,
>  		case IIO_LIGHT:
>  			ret = gp2ap002_get_lux(gp2ap002);
>  			if (ret < 0)
> -				return ret;
> +				goto out;
>  			*val = ret;
>  			ret = IIO_VAL_INT;
>  			goto out;

