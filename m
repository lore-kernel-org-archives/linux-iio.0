Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A521AF4F1;
	Mon, 23 Feb 2026 21:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771881352; cv=none; b=S8lGd0TfD2T7PdeMMl+0VCl+2/b1w7HWIcWGdumDynu71+EtO1WnRYq03z495BDhJFUqqDoJKSYdDZl6dAd22phmMwotnQ7mcdWNYVtKMCsm2SsvDWi2Mr4IdoGNxrMyCVO8iNXskaPWEFuRKHmuH+h770T/np/9rk9Y6hpNQjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771881352; c=relaxed/simple;
	bh=m7v/OTbCrNzxO4spqV66OJCmgv7ApB5+98zMrSh5OcY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCnXqzizOp48EH1wjDLygrWGuOKqFPhvnLc0I1ceu3IPxcgiy+JRhjLeFtbLmI4LvBxoBWNGeVT6W7PTijQQ2uZYUBPNqi7PfDVCzz9HAR3MM8Mak+WqHWNmp/knn7jHoKHvh2bAF0tuCLiX/Bma0kQTxWvk4Fgya7MdYPnK6MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHNBvGfm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHNBvGfm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCA6C116C6;
	Mon, 23 Feb 2026 21:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771881352;
	bh=m7v/OTbCrNzxO4spqV66OJCmgv7ApB5+98zMrSh5OcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CHNBvGfmEC2nv65T6c/3HmdzIqssNjJlfesI63Wte3NjEqEO2fhCnsSmrn7Wv1WyP
	 JUvspbUSVUInN0Ou2/9jvtAtNwARO1XypKBqr0Z8GKlr1bi0SK0ncgDoFXt3ceU7TO
	 HDX+Nf45AXpvpQU+ZQm9taGcPs92ZK38HZ//cnZVsZBKeU/kVgBRKP8BDhu1VL23GK
	 Mx5rbqvVDzscf/atWbLutjn6mqXXXyxL8lVrGO8zQ48psudiWtBrFo5lck1BCHM07i
	 DJFxwaQgWGk1a28WgyvtbImueT8ugHNIeZE3hI3bP64VhVX0xp468Ixu+rpoHdyfoh
	 mh4K5/d/B1Ksw==
Date: Mon, 23 Feb 2026 21:15:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ethan Tidmore <ethantidmore06@gmail.com>, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 05/10] iio: light: gp2ap020a00f: Fix possible error
 swallow
Message-ID: <20260223211544.7eeb67c2@jic23-huawei>
In-Reply-To: <aZxCf3zD7m3nxaH5@smile.fi.intel.com>
References: <20260223034020.27625-1-ethantidmore06@gmail.com>
	<20260223034020.27625-6-ethantidmore06@gmail.com>
	<aZxCf3zD7m3nxaH5@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Feb 2026 14:05:19 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Feb 22, 2026 at 09:40:15PM -0600, Ethan Tidmore wrote:
> > Move error check into for loop in gp2ap020a00f_buffer_postenable() and
> > gp2ap020a00f_buffer_predisable(), this fixes a possible error swallow.  
> 
> ...
> 
> > -	int i, err = 0;
> > +	int i, err;  
> 
> I believe we can't do that without introducing a 'default' case.

I agree. I'm a bit confused why LLVM at least isn't moaning about this.

Anyhow, I'm not sure why it defaulted to 0 previously...

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index d2156e133b75..64be9b8ca5e3 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1365,6 +1365,9 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
                        err = gp2ap020a00f_exec_cmd(data,
                                        GP2AP020A00F_CMD_TRIGGER_PROX_EN);
                        break;
+               default:
+                       err = -EINVAL;
+                       break;
                }
                if (err)
                        return err;
@@ -1398,6 +1401,9 @@ static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
                        err = gp2ap020a00f_exec_cmd(data,
                                        GP2AP020A00F_CMD_TRIGGER_PROX_DIS);
                        break;
+               default:
+                       err = -EINVAL;
+                       break;
                }
                if (err)
                        return err;

Is the tweak I applied to resolve this.

Thanks,

Jonathan

> 
> >  	guard(mutex)(&data->lock);
> >  
> > @@ -1366,11 +1366,10 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
> >  					GP2AP020A00F_CMD_TRIGGER_PROX_EN);
> >  			break;
> >  		}
> > +		if (err)
> > +			return err;
> >  	}
> >  
> > -	if (err < 0)
> > -		return err;  
> 
> (Also you might want to mention dropping '< 0' for making the style consistent
>  taking into account that those functions won't return any positive values.)
> 
> >  	data->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
> >  	if (!data->buffer)
> >  		return -ENOMEM;
> > @@ -1381,7 +1380,7 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
> >  static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
> >  {
> >  	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
> > -	int i, err = 0;
> > +	int i, err;  
> 
> Ditto.
> 
> >  	guard(mutex)(&data->lock);
> >  
> > @@ -1400,11 +1399,10 @@ static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
> >  					GP2AP020A00F_CMD_TRIGGER_PROX_DIS);
> >  			break;
> >  		}
> > +		if (err)
> > +			return err;
> >  	}
> >  
> > -	if (err)
> > -		return err;
> > -
> >  	kfree(data->buffer);
> >  	return 0;
> >  }  
> 

