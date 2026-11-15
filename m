Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794703625;
	b=oPqLIxbXr7D7Iw8NajvRMtgMsGWWSme4bTjrw2mzL8avZmUUobIF7B8Pp8rnUtLnACDb
	 j/jztvTOew+E3+lroGBc1PsxLjvuFnxusn+eauXoSqDnHYePOU5bu0b5DNQsfmZnUIQ2w
	 HQrvjayJZNwIclEn1SFLB9HtTEM0Ff0Fz8rs+Tcyicwj/snkZwOOJNEGXBLZ9RwZLTpKv
	 CwVU9WGXruob7jYFC6srFpDPX2I1/WEOoaC2kfxOf/Z0T16s9/hhrlcKYMdq8fyRwHC5a
	 WcJKkhNiqUH8q85lkbuICw0Yb/dZWZ4twBbSSPvQQCJx9NNrsZGud+4sdKTSEN1BY4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794703625;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=CddUsSozhn0aLsLwKkadXFQN9Fn98WgxQqOVl0KlMXE=;
	b=rnd/r0DHoe+k/3rGTFJSB6vzkqtrz0XtIs4g7wfFLPOaRiT4b5Rz8GSMT4jKSFwzvB1E
	 HyPobrbs5hI1gWtrfdrRrDsXlFtxpb49CNyjj9+rJmY7IAMYwF3/TMMMQxsK02ncjParU
	 5HpoiQ1SiGKxu1rfn0tRTLZikbqGh9jkIwJpOKhD60rAzdFbLWeq9i8sYNaAY62Im4U3P
	 0Y3Cp9QOcY+T4Lz9sqGyWncYrxVFwTWq9nP2WiNCvbkrpT1owbUC4cFR8wthkY7SO7RcI
	 iFuN+Fd7FhhQCKbIsHlHWWQsxUTxd0FFujJ0pwY4CriPDyx5QJrUHH+mptrLCn62igw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JVB6PpBU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42852606A329;
	Sun, 15 Nov 2026 00:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JVB6PpBU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD6F1F000C4;
	Sun, 15 Nov 2026 00:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794703624;
	bh=CddUsSozhn0aLsLwKkadXFQN9Fn98WgxQqOVl0KlMXE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JVB6PpBUOA5eDNIf3icWlzRCwg0Oo3fe+3fIKoUCDgz8pitRehg9+nBLiUc/VaQai
	 8MvqPchwRdaXtTItORMn+iEXtl6S7UdfTmaM80imgJuE5WLY5zRybVvkLPAsi77wLV
	 LcgK5NCgXZTTQVcvPL+9rGESNUC2H0I6/CVdqtG1TV+ExGsJqLQww3JX/7cnztNTDR
	 WgHGpEul5tYc/iDI6oZB3R5ggZMfGdak+vvCmxty6xDRy92X7HLOLbwI8zKdzKzEPR
	 /SODn0J0FKK9gSX9TS1NtBm1Seubt3eShkqMLZ3pvyNYweLEPIwpdECd7wwf+Cfu4E
	 1+6pLfr+VaNbg==
Date: Sun, 15 Nov 2026 00:46:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Changyul Lee <lcy8047@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Daniel Baluta <daniel.baluta@nxp.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: free hrtimer and loop triggers on
 configfs release
Message-ID: <20261115004658.29112ab9@jic23-hlaptop>
In-Reply-To: <20261106180435.2638701-1-lcy8047@gmail.com>
References: <20261106180435.2638701-1-lcy8047@gmail.com>
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

On Fri,  6 Nov 2026 13:04:35 -0500
Changyul Lee <lcy8047@gmail.com> wrote:

> Removing an hrtimer or loop trigger through configfs causes a
> use-after-free:
> 
>   BUG: KASAN: slab-use-after-free in config_item_put+0x1f/0x60
>   Write of size 4 at addr ffff888001bf322c by task rmdir/71
>   Call Trace:
>    config_item_put+0x1f/0x60
>    configfs_rmdir+0x7b7/0x9f0
>    vfs_rmdir+0x291/0x7b0
>    ...
>   Allocated by task 70:
>    iio_trig_hrtimer_probe+0x46/0x2b0
>    iio_sw_trigger_create+0x11b/0x210
>    trigger_make_group+0x2f/0x70
>    configfs_mkdir+0x477/0xf00
>    ...
>   Freed by task 71:
>    kfree+0x121/0x390
>    iio_trig_hrtimer_remove+0x86/0xb0
>    trigger_drop_group+0x78/0xd0
>    configfs_rmdir+0x7b7/0x9f0
>    ...
> 
> On rmdir, trigger_drop_group() calls iio_sw_trigger_destroy(), and the
> ->remove() callback of the trigger frees the structure that embeds the  
> config_item. The config_item_put() in trigger_drop_group() and the
> final config_item_put() in configfs_rmdir() then access freed memory.
> 
> Free the structure from the ->release() callback of the
> config_item_type instead, which configfs calls when the last reference
> is dropped. Documentation/filesystems/configfs.rst requires this
> callback for dynamically allocated items.
> 
> Fixes: ac5006a2a558 ("iio: trigger: Introduce IIO hrtimer based trigger")
> Fixes: bc2e1126eccb ("iio:trigger: Experimental kthread tight loop trigger (thread only)")
> Signed-off-by: Changyul Lee <lcy8047@gmail.com>

This looks correct to me and I'm going to queue it but I would prefer
to get some more eyes on it even so!

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
> Found with KASAN.
> 
> Reproduced in QEMU (x86_64, KASAN) by running mkdir and then rmdir on
> an hrtimer trigger and a loop trigger in configfs. Without this patch,
> KASAN reports the use-after-free on the first rmdir of each. With it,
> 1000 rounds of mkdir and rmdir on both trigger types give no KASAN
> report.
> 
>  drivers/iio/trigger/iio-trig-hrtimer.c | 13 ++++++++++++-
>  drivers/iio/trigger/iio-trig-loop.c    | 17 ++++++++++++-----
>  2 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
> index 57550b581593..469bd83331b2 100644
> --- a/drivers/iio/trigger/iio-trig-hrtimer.c
> +++ b/drivers/iio/trigger/iio-trig-hrtimer.c
> @@ -29,7 +29,19 @@ struct iio_hrtimer_info {
>  	ktime_t period;
>  };
>  
> +static void iio_hrtimer_release(struct config_item *item)
> +{
> +	struct iio_sw_trigger *swt = to_iio_sw_trigger(item);
> +
> +	kfree(container_of(swt, struct iio_hrtimer_info, swt));
> +}
> +
> +static const struct configfs_item_operations iio_hrtimer_item_ops = {
> +	.release = iio_hrtimer_release,
> +};
> +
>  static const struct config_item_type iio_hrtimer_type = {
> +	.ct_item_ops = &iio_hrtimer_item_ops,
>  	.ct_owner = THIS_MODULE,
>  };
>  
> @@ -176,7 +188,6 @@ static int iio_trig_hrtimer_remove(struct iio_sw_trigger *swt)
>  	/* cancel the timer after unreg to make sure no one rearms it */
>  	hrtimer_cancel(&trig_info->timer);
>  	iio_trigger_free(swt->trigger);
> -	kfree(trig_info);
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/trigger/iio-trig-loop.c b/drivers/iio/trigger/iio-trig-loop.c
> index 580a465035d1..e6bea96cc565 100644
> --- a/drivers/iio/trigger/iio-trig-loop.c
> +++ b/drivers/iio/trigger/iio-trig-loop.c
> @@ -35,7 +35,19 @@ struct iio_loop_info {
>  	struct task_struct *task;
>  };
>  
> +static void iio_loop_release(struct config_item *item)
> +{
> +	struct iio_sw_trigger *swt = to_iio_sw_trigger(item);
> +
> +	kfree(container_of(swt, struct iio_loop_info, swt));
> +}
> +
> +static const struct configfs_item_operations iio_loop_item_ops = {
> +	.release = iio_loop_release,
> +};
> +
>  static const struct config_item_type iio_loop_type = {
> +	.ct_item_ops = &iio_loop_item_ops,
>  	.ct_owner = THIS_MODULE,
>  };
>  
> @@ -111,13 +123,8 @@ static struct iio_sw_trigger *iio_trig_loop_probe(const char *name)
>  
>  static int iio_trig_loop_remove(struct iio_sw_trigger *swt)
>  {
> -	struct iio_loop_info *trig_info;
> -
> -	trig_info = iio_trigger_get_drvdata(swt->trigger);
> -
>  	iio_trigger_unregister(swt->trigger);
>  	iio_trigger_free(swt->trigger);
> -	kfree(trig_info);
>  
>  	return 0;
>  }
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

