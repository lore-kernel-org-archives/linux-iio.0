Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F153314D35
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027151; cv=none; b=MYlS9/XzeovtEaIhtwxp0payyz+P6HygBllN+WcZL9z9k5yQLEAPwc03HLylKi3N98TP4L1ecFdExyTQGTd/NRA4UPrPzasNXppD+RiugG0OwFgBDoAYgaf/HJ4dWE5B7mtjw6xsA1jf8z3EWpRIBrs2OuSNOdvrKL74eR+HbCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027151; c=relaxed/simple;
	bh=7N/nc0xlsy4IWIuhx+AL87SIid9cu+XzI2U6Uu3oK+w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKeDZQE5KlthCjMK3PMOHbcpoPeVBnB8xsuG5qwu/PBv4gx5Uh8UKpYwf//PWUl7VP5gZ+u/tzJ0OjTE6EzVXeNzQCtnTe3Emji/ADeQDktkgfCfazJvNH8IaQbE0XB899ZkGSzTvF5uQ4DDn+UtPnPN20J8Kq5R66wP86DWesM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzxVkLBP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzxVkLBP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257D7C19425;
	Fri, 24 Apr 2026 10:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777027150;
	bh=7N/nc0xlsy4IWIuhx+AL87SIid9cu+XzI2U6Uu3oK+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nzxVkLBP8NhSbCPIZnhh6lT+SRPCDdZhEPNgfpn5dBg+drt73OcT+hqsOADqqqjnJ
	 q2Awl7JvYo2AuNKIzGEYCDreEne+775PnszWxWJECUTUXAJxT7yvdMfR6lbVmAEBy/
	 x0jnX1ijIz20xX3Ut7s9996RjH2ub+uM7WxGETgvjS9C0TrpVKxyV8Qvuw6c/I/zLf
	 /iLLiwZSsDlZqzrK3Xfvhklb9a0ppwsQwyVnsfOI+lThJjgKLnKZv5VTrzYKq5K03v
	 OS6UHQoDkzbeMJZlPAN2v13Fc9qqNRT6crTL/NFoazJqQkGa7ZjSs+izDOR/0H5I9r
	 Jt6cXRQhwqG9A==
Date: Fri, 24 Apr 2026 11:39:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Guilherme Dias <guilhermeabreu200105@usp.br>, nish.malpani25@gmail.com,
 lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, =?UTF-8?B?Sm/Do28=?= Paulo Menezes
 Linaris <jplinaris@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: gyro: adxrs290: Use guard(mutex) in lieu of
 manual lock+unlock
Message-ID: <20260424113901.0508dbc2@jic23-huawei>
In-Reply-To: <aes2tzgfXbuD6ccQ@ashevche-desk.local>
References: <20260423223958.100487-1-guilhermeabreu200105@usp.br>
	<aes2tzgfXbuD6ccQ@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Apr 2026 12:24:07 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Apr 23, 2026 at 07:37:51PM -0300, Guilherme Dias wrote:
> > Use guard(mutex) to automatically release the lock on scope exit,
> > simplifying the error handling path and removing the need for
> > explicit unlock and goto-based cleanup.  
> 
> ...
> 
> >  static int adxrs290_get_rate_data(struct iio_dev *indio_dev, const u8 cmd, int *val)
> >  {
> >  	struct adxrs290_state *st = iio_priv(indio_dev);
> > -	int ret = 0;
> >  	int temp;
> >  
> > -	mutex_lock(&st->lock);
> > +	guard(mutex)(&st->lock);  
> 
> + blank line.
> 
> We usually consider guard()() as not semantically linked to any code above
> or below
> 
> >  	temp = spi_w8r16(st->spi, cmd);
> > -	if (temp < 0) {
> > -		ret = temp;
> > -		goto err_unlock;
> > -	}
> > +	if (temp < 0)
> > +		return temp;
> >  
> >  	*val = sign_extend32(temp, 15);
> > -
> > -err_unlock:
> > -	mutex_unlock(&st->lock);
> > -	return ret;
> > +	return 0;
> >  }  
> 
> Ditto for the similar cases below.
> 
> ...
> 
> > static int adxrs290_set_mode(struct iio_dev *indio_dev, enum adxrs290_mode mode)  
> 
> >  	default:
> >  		ret = -EINVAL;
> > -		goto out_unlock;
> > +		return ret;  
> 
> Just return directly the given error code.
> 
> ...
> 
> > static irqreturn_t adxrs290_trigger_handler(int irq, void *p)  
> 
> > -	mutex_lock(&st->lock);
> > +	scoped_guard(mutex, &st->lock){  
> 
> No. Besides wrong style of this line, this has a very broken indentation now.
> 
> >  	/* exercise a bulk data capture starting from reg DATAX0... */
> >  	ret = spi_write_then_read(st->spi, &tx, sizeof(tx), st->buffer.channels,
> >  				  sizeof(st->buffer.channels));
> > -	if (ret < 0)
> > -		goto out_unlock_notify;
> > -
> > -	iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
> > +	if (ret >= 0)
No to this as well. Keep the error out of line.  Which makes the use
of guard() here tricky.  You could do a do { guard(); } while(0) loop so that
you can use break with out it being odd looking.

(I don't like breaks out of scoped_guard() because it's non obvious scoped
guard is actually a loop.

> > +		iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
> >  					   pf->timestamp);
> > +	}

> >  
> > -out_unlock_notify:
> > -	mutex_unlock(&st->lock);  
> 
> >  	iio_trigger_notify_done(indio_dev->trig);
> > -
> >  	return IRQ_HANDLED;  
> 
> Stray change.
> 
> >  }  
> 

