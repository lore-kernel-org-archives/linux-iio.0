Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD023A1D05;
	Mon, 20 Apr 2026 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776707898; cv=none; b=bHvCHhJTgoOahnopA9nx2yzQPARjkeEtfEqDw17yoJEGpUgi24lG0AJmPEVFCzSNzCn/wJgmBGoUyuLQgKHaH6vIdI4Wj3AwYMSPwDln9iV6jKuUw8gswD9oqKWvtd9xanJH894lowMaQvS9O7OeWx7Ec5FFw3R4g7YVvtZ7yy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776707898; c=relaxed/simple;
	bh=loA65GrEhgZP61+HZTQhHidAq+shi8hD5OJvIfN+foU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CsUtYq73Dl3iyWa4Tvb7S+FQoo0lqeFBAZa3UnsSg4m5rSe+DXb65XPRIyuIwPIUa3cB1NlBKGjlmOrugfXmarW0+yF1pNOkqNhiQInT8qTN43ArJm7nD2G5OhjpXFXAOPU8zN28GLY3y5CkUHRO2FdooTRi6tV1WzW6l0/3Wl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ojeock6C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ojeock6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF35C19425;
	Mon, 20 Apr 2026 17:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776707898;
	bh=loA65GrEhgZP61+HZTQhHidAq+shi8hD5OJvIfN+foU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ojeock6C8tzD64p/bHaST38UEsWakhCNjmuZFw6TdO5RWgi0a1ZTMGpVP4sHCCdhH
	 OtiTuwZeZLqNxEPSbgyL102OAb5Bt8gqxUProFUOyZ87ZWBbmp6pXWs+i37hj30+Ua
	 F/BaaxkZpnmzG1FxVJyOi0yfRNW3ZLE5OKc/aJKfmAOab8ZmLsy1wHntrkbKJrGxsQ
	 ljaHmH504gXok8NFwe0ATX32I38a0LxpzUOVAf3JzE/lwxqrDuHKhwZjzRRhZFUnzw
	 Rj5zEUpVQ4u5/ecS+Ng80uWc6Iq40GcIzhUhe8eyWAwbZSeURBJ2Ug6klNc8rvIlbH
	 wxCvME1gRv/Kg==
Date: Mon, 20 Apr 2026 18:58:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Antony Kurniawan Soemardi <linux@smankusors.com>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 phone-devel@vger.kernel.org, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/3] iio: adc: qcom-pm8xxx-xoadc: add support for
 reading channel labels
Message-ID: <20260420185807.24817684@jic23-huawei>
In-Reply-To: <adQNlfiq4aaOJ2ll@ashevche-desk.local>
References: <20260405-pm8xxx-xoadc-label-v3-0-9fe179c283ec@smankusors.com>
	<20260405-pm8xxx-xoadc-label-v3-3-9fe179c283ec@smankusors.com>
	<adQNlfiq4aaOJ2ll@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Apr 2026 22:46:29 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Apr 05, 2026 at 04:52:21PM +0000, Antony Kurniawan Soemardi wrote:
> > Implement the .read_label callback to allow userspace to identify ADC
> > channels via the "label" property in the device tree. The name field in
> > pm8xxx_chan_info is renamed to label to better reflect its purpose. If
> > no label is provided in the device tree, it defaults to the hardware
> > datasheet name.  
> 
> > The change has been tested on Sony Xperia SP (PM8921).  
> 
> ...
> 
> > +static int pm8xxx_read_label(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan, char *label)
> > +{
> > +	struct pm8xxx_xoadc *adc = iio_priv(indio_dev);  
> 
> > +	struct pm8xxx_chan_info *ch = pm8xxx_get_channel(adc, chan->address);  
> 
> When you have a validation the better style is to split definition and
> assignment. This makes code robust against (theoretically) possible changes
> that might reuse the same variable for something else.

I think you just mean

	struct pm8xx_chan_info *ch;

	ch = pm8xx_get_...
	if (!ch)
		return -EINVAL?

I suppose slightly better but it's a very small function and unlikely to have
much complexity added to it.
> 
> > +	if (!ch)
> > +		return -EINVAL;
> > +	return sysfs_emit(label, "%s\n", ch->label);
> > +}  
> 
> Again, no need to resend now, just make it in the next version if that version
> is asked for.
> 

