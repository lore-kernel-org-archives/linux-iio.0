Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272043002A9;
	Fri, 15 May 2026 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857553; cv=none; b=H6PnhDWsFhqpxb4/V8n0fNUhSMSKO1uTv8AMpK3oxqie1f9QkAeYgvCTrYewu4ykAvxLFWAqOg63EtvGBTDx2SOU4kbxKzdVoDI1/3WjCcxuUsxrhRey2iWhyEJ8ud50kTZYVftxy7OTxXOcZxLTWuPIzPbsq+xTkXq7YvN0q/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857553; c=relaxed/simple;
	bh=S97C/KlOBLA0A5zdQCJjCSKK2QuEAKkKCk/Nwjjp3J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrlsdRmbQOeU1jCw5V8JHqBUYeRuIB5jHw6l0fhxg96S1vRYGqELQEU9Q/dyknpJNPUVOj2s5eLtLX+rfcfglnM/DveTOBelxq/CCu3gfew1BHnIHXr4U3awWXgLQTxPgPehNMF5yiihEWi876ZneIIeNCwJ0SaZ2M2+1z9FPtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vsEKCCF4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vsEKCCF4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91660C2BCB0;
	Fri, 15 May 2026 15:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778857553;
	bh=S97C/KlOBLA0A5zdQCJjCSKK2QuEAKkKCk/Nwjjp3J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vsEKCCF4NPWo6W/6ijfdBlkmS4bON4+BzFX3dvAWHmKiJuT2Lmj+Usm7dmic6Ky9E
	 zFhRy17MQsj/gPRm/PhhW8rXzcQIyVkVsFr4KgB+/ukAtdKiphkmBsum5nSsEiSt/Q
	 xN++OS/0KQvOC3c9VaeTujRc/D+T8X529+PIBrck=
Date: Fri, 15 May 2026 17:05:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sam Daly <sam@samdaly.ie>, stable <stable@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 2/3] iio: light: veml6075: add bounds check to
 veml6075_it_ms index
Message-ID: <2026051527-petri-obstruct-0312@gregkh>
References: <2026051420-strudel-graves-f6cd@gregkh>
 <2026051422-hungry-dolly-0250@gregkh>
 <DIIN3H0YMILE.3PFQWDK2BULIT@gmail.com>
 <20260515153236.1acf1ca4@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515153236.1acf1ca4@jic23-huawei>

On Fri, May 15, 2026 at 03:33:07PM +0100, Jonathan Cameron wrote:
> On Fri, 15 May 2026 08:17:18 +1300
> "Javier Carrasco" <javier.carrasco.cruz@gmail.com> wrote:
> 
> > On Fri May 15, 2026 at 5:23 AM +13, Greg Kroah-Hartman wrote:
> > > From: Sam Daly <sam@samdaly.ie>
> > >
> > > veml6075_it_ms has 5 elements but VEML6075_CONF_IT can yield
> > > values 0-7. If it returns a value >= 5, this causes an
> > > out-of-bounds array access. Add a bounds check and return
> > > -EINVAL if the index is out of range.
> 
> I'd prefer it if this sort of change called out that we don't expect
> to ever see those values except when we have bus corruption or
> a broken device.  Good to protect against but that info might help
> folk decide whether to backport or not.

Thanks.  This came from a run of "look at all of these bugfixes and find
where we need to also apply the same pattern" of my bot.

> I'll add a note whilst applying.  Applied to the fixes-togreg
> branch of iio.git.  I also rewrapped the description as 60 chars
> is rather short.

Thanks!

greg k-h
