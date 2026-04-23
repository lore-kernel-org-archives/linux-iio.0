Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761162E62A9
	for <linux-iio@vger.kernel.org>; Thu, 23 Apr 2026 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776944540; cv=none; b=It4N8Rzx2juOLv83t0l+VnX9Idzp4jxFycMBKnz4uDw/DkSAXupi62uLgvuqsa+Uhb6o4Ew6e/k5Zayc4c10dnzKdg4/MQV8d7+Xl6C+RsFQ/tMAxj+Drd/wCm42pNMwGKdcvLOjOhzG3RW48G7NmkW+IuupYd4It6Mp2vEgwTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776944540; c=relaxed/simple;
	bh=jgu+IZ//0c7A7q0R1oQz5OexorzBSccbRDhdmXTxtAw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AGhY0fS+u7kwggdTK/bQeYt9GQZUIgx7w9ca12kMZMMjbpiLZ49q/KGv0RGhOEdY6CYvJTyUrAe4R/lP28m4JVttZGYmqGvdz+5tG/qMPh/z5PKCCuWB+hRUlht8JFPbMErqK0u75A/pXnnYgv7IuE13w4rSpCTDL76NJXWDsfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aUxWijqa; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aUxWijqa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776944540; x=1808480540;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jgu+IZ//0c7A7q0R1oQz5OexorzBSccbRDhdmXTxtAw=;
  b=aUxWijqa99/MCsiXA8YiJ0j1oKVTdP6A3CCs/MtrJeRmoKhduUxk3Exr
   skplO2JaKNVz4fZ7OJZycgzbJLPxRXgMX0xi13VfdqfJNpuhxj4+3vKu6
   Bw2zPeFl3BNaE0DDt+3oObr3LWUgdJ2tc3xjVRF0x5lpfPZvWn4ONqLLh
   7VkiqIhWbkvaAKsEO9YXIzXHmAat5ZdJpwI6hXp7QtfualEsWH17cJYpB
   +OKp9uyCDR6jVQZmoudQ0nuMFs5X1imV2il7cnJmevVdw1M0p/NoGoplT
   SvHXIUWL1odEfmdE3iYp8jhVvqnDf138ADc8anrDBF239PdzLRPjTOig+
   A==;
X-CSE-ConnectionGUID: QJUyeFEoRLKqp6IK+3WH3g==
X-CSE-MsgGUID: CcezWzJqS8e2yYroOutZHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="81772130"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="81772130"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 04:42:19 -0700
X-CSE-ConnectionGUID: t3FJcxL0SF6GvcOAQQz/XA==
X-CSE-MsgGUID: 1bhbXciPQpicY2+dJaMPEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; 
   d="scan'208";a="226113790"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.212])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 04:42:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 23 Apr 2026 14:42:13 +0300 (EEST)
To: Joao Paulo Menezes Linaris <jplinaris@usp.br>
cc: wbg@kernel.org, Guilherme Dias <guilhermeabreu200105@usp.br>, 
    linux-iio@vger.kernel.org
Subject: Re: [PATCH] counter: intel-qep: Replace manual mutex logic with lock
 guards
In-Reply-To: <20260422210537.12127-1-jplinaris@usp.br>
Message-ID: <3ab73ef5-0a3a-66b4-a763-398f0921c289@linux.intel.com>
References: <20260422210537.12127-1-jplinaris@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 22 Apr 2026, Joao Paulo Menezes Linaris wrote:

> Use scoped_guard() for handling mutex lock instead of locking and unlocking mutex explicitly. This improves readability by eliminating the need for gotos and by clearly indicating mutex will be locked only when execution is in scoped_guard() scope.

Please fold the changelog text properly.

> 
> Signed-off-by: Joao Paulo Menezes Linaris <jplinaris@usp.br>
> Co-developed-by: Guilherme Dias <guilhermeabreu200105@usp.br>
> Signed-off-by: Guilherme Dias <guilhermeabreu200105@usp.br>
> ---
>  drivers/counter/intel-qep.c | 126 +++++++++++++++++-------------------
>  1 file changed, 58 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
> index c49c17805..199a8d562 100644
> --- a/drivers/counter/intel-qep.c
> +++ b/drivers/counter/intel-qep.c
> @@ -188,25 +188,22 @@ static int intel_qep_ceiling_write(struct counter_device *counter,
>  				   struct counter_count *count, u64 max)
>  {
>  	struct intel_qep *qep = counter_priv(counter);
> -	int ret = 0;
>  
>  	/* Intel QEP ceiling configuration only supports 32-bit values */
>  	if (max != (u32)max)
>  		return -ERANGE;
>  
> -	mutex_lock(&qep->lock);
> -	if (qep->enabled) {
> -		ret = -EBUSY;
> -		goto out;
> -	}
> +	/* Lock mutex while execution in scoped_guard() scope */

Why add dead obvious comments like this. Please don't do it.

> +	scoped_guard(mutex, &qep->lock){
> +		if (qep->enabled) 
> +			return -EBUSY;
>  
> -	pm_runtime_get_sync(qep->dev);
> -	intel_qep_writel(qep, INTEL_QEPMAX, max);
> -	pm_runtime_put(qep->dev);
> +		pm_runtime_get_sync(qep->dev);
> +		intel_qep_writel(qep, INTEL_QEPMAX, max);
> +		pm_runtime_put(qep->dev);
> +	}
>  
> -out:
> -	mutex_unlock(&qep->lock);
> -	return ret;
> +	return 0;

Why is using scoped variable of guard necessary in these cases??? Are 
you just making these changes using some tool without inspecting if the 
end result makes sense or not??

Also, runtime PM also has guards support added (admittedly changing them 
doesn't remove gotos). But one of the cases seems non-pairing so that 
seems not convertable to guard.

>  }
>  
>  static int intel_qep_enable_read(struct counter_device *counter,
> @@ -226,28 +223,28 @@ static int intel_qep_enable_write(struct counter_device *counter,
>  	u32 reg;
>  	bool changed;
>  
> -	mutex_lock(&qep->lock);
> -	changed = val ^ qep->enabled;
> -	if (!changed)
> -		goto out;
> -
> -	pm_runtime_get_sync(qep->dev);
> -	reg = intel_qep_readl(qep, INTEL_QEPCON);
> -	if (val) {
> -		/* Enable peripheral and keep runtime PM always on */
> -		reg |= INTEL_QEPCON_EN;
> -		pm_runtime_get_noresume(qep->dev);
> -	} else {
> -		/* Let runtime PM be idle and disable peripheral */
> -		pm_runtime_put_noidle(qep->dev);
> -		reg &= ~INTEL_QEPCON_EN;
> +	/* Lock mutex while execution in scoped_guard() scope */
> +	scoped_guard(mutex, &qep->lock){
> +		changed = val ^ qep->enabled;
> +		if (!changed) 
> +			return 0;
> +
> +		pm_runtime_get_sync(qep->dev);
> +		reg = intel_qep_readl(qep, INTEL_QEPCON);
> +		if (val) {
> +			/* Enable peripheral and keep runtime PM always on */
> +			reg |= INTEL_QEPCON_EN;
> +			pm_runtime_get_noresume(qep->dev);
> +		} else {
> +			/* Let runtime PM be idle and disable peripheral */
> +			pm_runtime_put_noidle(qep->dev);
> +			reg &= ~INTEL_QEPCON_EN;
> +		}
> +		intel_qep_writel(qep, INTEL_QEPCON, reg);
> +		pm_runtime_put(qep->dev);
> +		qep->enabled = val;
>  	}
> -	intel_qep_writel(qep, INTEL_QEPCON, reg);
> -	pm_runtime_put(qep->dev);
> -	qep->enabled = val;
>  
> -out:
> -	mutex_unlock(&qep->lock);
>  	return 0;
>  }
>  
> @@ -279,7 +276,6 @@ static int intel_qep_spike_filter_ns_write(struct counter_device *counter,
>  	struct intel_qep *qep = counter_priv(counter);
>  	u32 reg;
>  	bool enable;
> -	int ret = 0;
>  
>  	/*
>  	 * Spike filter length is (MAX_COUNT + 2) clock periods.
> @@ -300,25 +296,23 @@ static int intel_qep_spike_filter_ns_write(struct counter_device *counter,
>  	if (length > INTEL_QEPFLT_MAX_COUNT(length))
>  		return -ERANGE;
>  
> -	mutex_lock(&qep->lock);
> -	if (qep->enabled) {
> -		ret = -EBUSY;
> -		goto out;
> +	/* Lock mutex while execution in scoped_guard() scope */
> +	scoped_guard(mutex, &qep->lock){
> +		if (qep->enabled)
> +			return -EBUSY;
> +
> +		pm_runtime_get_sync(qep->dev);
> +		reg = intel_qep_readl(qep, INTEL_QEPCON);
> +		if (enable)
> +			reg |= INTEL_QEPCON_FLT_EN;
> +		else
> +			reg &= ~INTEL_QEPCON_FLT_EN;
> +		intel_qep_writel(qep, INTEL_QEPFLT, length);
> +		intel_qep_writel(qep, INTEL_QEPCON, reg);
> +		pm_runtime_put(qep->dev);
>  	}
>  
> -	pm_runtime_get_sync(qep->dev);
> -	reg = intel_qep_readl(qep, INTEL_QEPCON);
> -	if (enable)
> -		reg |= INTEL_QEPCON_FLT_EN;
> -	else
> -		reg &= ~INTEL_QEPCON_FLT_EN;
> -	intel_qep_writel(qep, INTEL_QEPFLT, length);
> -	intel_qep_writel(qep, INTEL_QEPCON, reg);
> -	pm_runtime_put(qep->dev);
> -
> -out:
> -	mutex_unlock(&qep->lock);
> -	return ret;
> +	return 0;
>  }
>  
>  static int intel_qep_preset_enable_read(struct counter_device *counter,
> @@ -342,28 +336,24 @@ static int intel_qep_preset_enable_write(struct counter_device *counter,
>  {
>  	struct intel_qep *qep = counter_priv(counter);
>  	u32 reg;
> -	int ret = 0;
> -
> -	mutex_lock(&qep->lock);
> -	if (qep->enabled) {
> -		ret = -EBUSY;
> -		goto out;
> -	}
>  
> -	pm_runtime_get_sync(qep->dev);
> -	reg = intel_qep_readl(qep, INTEL_QEPCON);
> -	if (val)
> -		reg &= ~INTEL_QEPCON_COUNT_RST_MODE;
> -	else
> -		reg |= INTEL_QEPCON_COUNT_RST_MODE;
> +	/* Lock mutex while execution in scoped_guard() scope */
> +	scoped_guard(mutex, &qep->lock){
> +		if (qep->enabled) 
> +			return -EBUSY;
>  
> -	intel_qep_writel(qep, INTEL_QEPCON, reg);
> -	pm_runtime_put(qep->dev);
> +		pm_runtime_get_sync(qep->dev);
> +		reg = intel_qep_readl(qep, INTEL_QEPCON);
> +		if (val)
> +			reg &= ~INTEL_QEPCON_COUNT_RST_MODE;
> +		else
> +			reg |= INTEL_QEPCON_COUNT_RST_MODE;
>  
> -out:
> -	mutex_unlock(&qep->lock);
> +		intel_qep_writel(qep, INTEL_QEPCON, reg);
> +		pm_runtime_put(qep->dev);
> +	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static struct counter_comp intel_qep_count_ext[] = {
> 

-- 
 i.

