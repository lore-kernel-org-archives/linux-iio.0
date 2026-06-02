Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5363806AF;
	Tue,  2 Jun 2026 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401045; cv=none; b=X8rwtvul0iuBBN+L7Ft7k//FoDOEPMYrIgAEAimlrMSYZnlzRFNk2rIIw1H6G01M+iKlAYy/h8tC0l+gg318HrFUUKa/v6zmwR4X3SI8yqjK5mBxqvIcK9lkl3394JWbr5u3s9e7A4AtERxi5CyVP4104xOhX00p2wJl5fJHqX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401045; c=relaxed/simple;
	bh=PX0UWFtVPIsOVOUfhKE7PQQhE+kNLDNB8K1kAP/nuEU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jcZCRmxviyHmSNAB0mRdBKWI5tkNypgZNhRJakOLQaVZ8z8OukbhNux2qNrJoyol/heXZDzcZwEu7iCJ3C5P6lzIefwHNnEUjusmutxtO1pFT0bjYzt6LiyoPrSHqcZo0ppFTQrbGpToXwFKBxBNW1Vcm/6fHAdSR7SJ1Qeq6r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGk/G6GP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGk/G6GP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59BD1F00893;
	Tue,  2 Jun 2026 11:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780401044;
	bh=kDz4qtu8jJNPjfA+1JITm8SH77/HGTAD92ZdL2toOJs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PGk/G6GP9YqKF6qY3mNKfeaOZwepzaMM/RjFoIrVDTJwu/w46hjE2J+B9lZ9Ai8hw
	 PISe1gif5B9xlLzgbNW+dIyoNqaEEIvJUMFrov21kEqFOUu6Scl18c1jZO1pEYs8Qa
	 ggUfGdZbnhoHXRk9CP5IRS3o0dM2p2Vtoi0hzd3sOlFEQyg92QwH7tr97LMZU/Shol
	 n00ykrcba0SfVhpv58cEdDvKLD6cN2rsSaaFCcsjAIdHfPX/eZL5rXf6KydbmItVZa
	 XPd3eL9BZCtKnSTgxWcuo8aqpBb/wbUKgpJ3VqZsXJwsWw2p/urGV91ZKiWUyLuXg+
	 QrDr5JW4cE63Q==
Date: Tue, 2 Jun 2026 12:50:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Maxwell Doose <m32285159@gmail.com>, Tomasz Duszynski
 <tduszyns@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open
 list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] iio: chemical: sps30: Replace manual locking with
 RAII locking
Message-ID: <20260602125040.4a217130@jic23-huawei>
In-Reply-To: <ah6C2vFPiflM7Qvg@ashevche-desk.local>
References: <20260523181536.5254-2-m32285159@gmail.com>
	<ah6C2vFPiflM7Qvg@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jun 2026 10:14:34 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, May 23, 2026 at 01:15:36PM -0500, Maxwell Doose wrote:
> > Replace manual mutex_lock() and mutex_unlock() calls with the much newer
> > guard(mutex)() and scoped_guard() macros to enable RAII patterns,
> > modernize the driver, and to increase readability.
> > 
> > Move mutex locking into sps30_do_meas() and tune it up to use guard()(),
> > as every caller takes the lock anyways.  
> 
> ...
> 
> > -	mutex_lock(&state->lock);
> > +	guard(mutex)(&state->lock);
> > +
> >  	ret = state->ops->write_cleaning_period(state, cpu_to_be32(val));
> > -	if (ret) {
> > -		mutex_unlock(&state->lock);
> > +	if (ret)
> >  		return ret;
> > -	}
> >  
> >  	msleep(20);  
> 
> Same question as per v4 (yes, I see that it was in the original code).
> 
I relied to v4.  I think it is the correct thing to do as adds a penalty
for stupid userspace code and doesn't complicate the driver like other
solutions would do.

J

