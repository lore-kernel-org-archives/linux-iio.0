Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794015126;
	b=aN7yu4HEmNaHms2L/q02GeKwZp8OSmo6c6qmD1oTLYjhR4HqgeNOCOsgHc4W1QKFg2P4
	 ODGVLdm82p9cvvs+yOS79Jx5K71/JBPnvXjzAn3QSvUSTgJa2/4jnOuTWg8hJJPkPNeJi
	 sCviqHVEOT4w5/aT5jVOOe3AYujuILtwskd9msTtAQRc2nivXwgtyeI/IHHhoZDE/Y0I9
	 m+SA0vzJf4q2KFhJTkWScyWz3Wb3Wtt6ykPpVQRg9TbI77nZCjEQCzb59mRYSXsaRV7s5
	 uxNEYdN9ClaJEtFXhgfwLUCZrDsA2GpAXCVEr/Ls8nUk8Y5ZdQt/N3Ebf6KEm6jXwuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794015126;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=78CmncQJcyLPPbStQUB4XqZbsG4eCHONJdeCn10o0jE=;
	b=D3HQOlJsiqi3bWq14rBzT8a4nGINy4FXkFHNsDPAhCVzxE8dOn842kFlMa+86T/diXcy
	 mBN0kF/9+vJYWHWtT+oRakBSrOUQjPgDT/kuLyJVVGvNdqSOEFHUZ+DfcOkgf8dgIVDo+
	 mm+gZhHBSitxKIJMqEiCb/cJU2ltiUWn/iRQo3tj+4pJpjLDc5Ag8xCMLEj3zwaUvTEV7
	 2A4+4d1f6x2qYZHsy8+lZfR6rgxIgdVUeb3ZvziF+KPrHaPLAtV+gUiv+VW7hSxNi5ieI
	 HZMTNaJeCDI9HYrNLmRK0blhXMa6HffIdC7BucQVJIk2/iaCu9dsfBJ3wleKnACtflA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FF24aqCY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FB0606A326;
	Sat,  7 Nov 2026 01:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FF24aqCY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509F91F0089F;
	Sat,  7 Nov 2026 01:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794015126;
	bh=78CmncQJcyLPPbStQUB4XqZbsG4eCHONJdeCn10o0jE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FF24aqCY4MJukyslgKY4rtOD1oZOi1V1kRy+jITnKaKC0GNn+KMfRb8q23tC3xcQk
	 RzhNVoBVJEZdJL7ub+aU1AxaolJLi9F9znd/GSB8r3roM0Dq5Z/57/eY+Zj7m7Np4n
	 Iflb5n+8X2e8zDvU6jpdRXi8EAZHD6rYkRQubd5gRTVkJ5L/2vMg1vMtBNahMDkq3M
	 H30h8fGBfOuovy/BHwIy7mrv53CrHfZhKdN3yjTQRWmrbaczhXL9JpoOkI2TCE4JDS
	 MOoc/XycEGKJhE04xHvfCOP1eFpsEjQWUZsQ/I+RqvXvRNLe0zcmzZ5C/Oh2lCM2Tu
	 0Kik/cd2dMxOg==
Date: Sat, 7 Nov 2026 01:31:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Changyul Lee <lcy8047@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: free the trigger ID after device_del()
Message-ID: <20261107013159.7df2ab9f@jic23-hlaptop>
In-Reply-To: <20261106174737.2580011-1-lcy8047@gmail.com>
References: <20261106174737.2580011-1-lcy8047@gmail.com>
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

On Fri,  6 Nov 2026 12:47:37 -0500
Changyul Lee <lcy8047@gmail.com> wrote:

> iio_trigger_unregister() returns the trigger ID to iio_trigger_ida
> before device_del() removes the "trigger<N>" device. A trigger
> registered in between can get the same ID, and its device_add() fails:
> 
>   sysfs: cannot create duplicate filename '/bus/iio/devices/trigger0'
> 
> For example, adding a sysfs trigger while an hrtimer trigger is being
> removed through configfs, or the other way around, hits this because the
> two paths do not share a lock.
> 
> Free the ID after device_del(), as the error path of
> iio_trigger_register() already does, and drop the "Possible issue in
> here" comment.
> 
> Fixes: 1637db44413e ("Staging: IIO: Trigger support added to core.")
> Signed-off-by: Changyul Lee <lcy8047@gmail.com>
Nice find. Applied to the fixes-togreg branch of iio.git.

One passing comment below given you also deleted a very 'odd'
comment!


> ---
> Found with a static analysis tool we are developing.
> 
> Reproduced in QEMU (x86_64) with two threads running for 20 seconds.
> One writes to add_trigger and remove_trigger of iio_sysfs_trigger, the
> other creates and removes an hrtimer trigger in configfs. Without this
> patch, device_add() failed with the error above 160 to 1148 times per
> run in three runs. With it, it never failed.
> 
>  drivers/iio/industrialio-trigger.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 76926fee0f84..206ede2c9b3c 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -105,9 +105,8 @@ void iio_trigger_unregister(struct iio_trigger *trig_info)
>  	scoped_guard(mutex, &iio_trigger_list_lock)
>  		list_del(&trig_info->list);
>  
> -	ida_free(&iio_trigger_ida, trig_info->id);
> -	/* Possible issue in here */
This made me wonder - what is that on about?  I checked
the history and all the code on either side of that comment has
changed since it was added.  So who knows! :)


>  	device_del(&trig_info->dev);
> +	ida_free(&iio_trigger_ida, trig_info->id);
>  }
>  EXPORT_SYMBOL(iio_trigger_unregister);
>  
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

