Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C7624468C;
	Fri, 29 May 2026 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075408; cv=none; b=V2EKjuNfQbPj+kaJN9Q41VeZ5XaNsk6m58mw4NGZU7nlMqP3WppPlv8qg1V8gtjkYHFjhkEWzrnW+aSrD4D2TrzB/NTpu8wx9Qvaqesz6Owsw4OS9lIvoBfn+G9JYXU4VUKO7UGKXKnspeUuuSohxpuPiIz1nPHYPhXPXAnt7ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075408; c=relaxed/simple;
	bh=o1Ppx5F8ILbSnbTrLuUxFiXQq9BP+DClHAooK/BuvX8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjHoqsDPHbxlKZSuznuq/NfaTgGzri/P+2zvF9Q8C6GZDWiJnAJyBc8XmSArDqN/4GtyXBKHaQb4Fk4BJMdUpHSStb8iLzY2CgWRl5wC7OJoi33zE4tGyE5FoWwBSSh4YSQNexOZbctGFHwt34wLP4r3gYXcYiu1bJT2ssvfdCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUWfgZox; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUWfgZox"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22521F00893;
	Fri, 29 May 2026 17:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780075407;
	bh=VFoD/m89b0QR6dpTiDuXKXFksWNK0HbB6KmqPeE9GF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jUWfgZox5kat/4nT/iBse7gKrzmN4uZUTpqedfvGCWvXElMFkzIbZSmGvO1Qi+Hl8
	 +ojvbnKmXcBmTmmIJxYVnE+Ox1y+k2wZ/5D/82drdLyEzyZ7uzxL/Rs6ESYPVbIWs7
	 vpoOK8lup89kizDrUtSLIcBgcC2L06VJm+IfqPEgCVUxvR1AihzAlA0DnHyvziFcNs
	 PsdkXJFZNAjSzBiyrGq0ET0Z3bNkJs6kfI7vzwT87c45J/ps9pNhPH0IrFcO3XtU35
	 csXxZCtMYP0EDwOxuhRwaPgF38WnQfCSQ1ops1vyxeF0uNcMo2RqQGmsVWenjT89qn
	 ObXIrS9aHCdxA==
Date: Fri, 29 May 2026 18:23:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: accel: mma8452: use devm_pm_runtime_enable()
 to fix probe error path
Message-ID: <20260529182320.4f45e53c@jic23-huawei>
In-Reply-To: <e10c970e911bf68e62e0a58d48b3513f1f947587.1780051096.git.sozdayvek@gmail.com>
References: <cover.1780051096.git.sozdayvek@gmail.com>
	<e10c970e911bf68e62e0a58d48b3513f1f947587.1780051096.git.sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 15:45:44 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> mma8452_probe() calls pm_runtime_enable() and then iio_device_register().
> If iio_device_register() fails the function jumps to buffer_cleanup but
> the existing manual unwind does not call pm_runtime_disable(), leaking the
> runtime PM enable_count on probe failure and on subsequent rebind.
> 
> Switch to devm_pm_runtime_enable() so the enable (and the matching
> dont_use_autosuspend) are torn down automatically.  On its new error path
> the probe jumps to the existing buffer_cleanup label so the triggered
> buffer, trigger and regulator cleanup chain stays intact.  The
> pm_runtime_disable() and pm_runtime_set_suspended() calls in
> mma8452_remove() are dropped; the devm action runs after .remove() and
> handles the teardown.
> 
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
Same again on not mixing devm with goto.

Side effect here is that the tear down order is completely different from
reverse of setup.

> ---
>  drivers/iio/accel/mma8452.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 15172ba2972c..88ed47d33e03 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1693,7 +1693,9 @@ static int mma8452_probe(struct i2c_client *client)
>  	if (ret < 0)
>  		goto buffer_cleanup;
>  
> -	pm_runtime_enable(&client->dev);
> +	ret = devm_pm_runtime_enable(&client->dev);
> +	if (ret)
> +		goto buffer_cleanup;
>  	pm_runtime_set_autosuspend_delay(&client->dev,
>  					 MMA8452_AUTO_SUSPEND_DELAY_MS);
>  	pm_runtime_use_autosuspend(&client->dev);
> @@ -1733,9 +1735,6 @@ static void mma8452_remove(struct i2c_client *client)
>  
>  	iio_device_unregister(indio_dev);
>  
> -	pm_runtime_disable(&client->dev);
> -	pm_runtime_set_suspended(&client->dev);
> -
>  	iio_triggered_buffer_cleanup(indio_dev);
>  	mma8452_trigger_cleanup(indio_dev);
>  	mma8452_standby(iio_priv(indio_dev));

