Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A231B31E844;
	Thu, 12 Mar 2026 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325684; cv=none; b=HAdmRZ91t9JqrXm64ZvQhI2HAiArZSUzXfgAh0hdFT6xRFJFu1sG0WmfJ+TV+FgCzqHB58p6SlyLoN/VHl0OOSWz7cA51OPMSNo93sM3+dGxIqbdOPh4hpbmnq3QOh0hQvAFBcd4q4kc63WFVIOKw0suBYQyplDixnqo39yqUOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325684; c=relaxed/simple;
	bh=Yq2ezdncoeCesXuhqcd/gqDzmwVwnT93JTqn7ydj8CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgAZ7tIPYGLC+LYMP2EQSWpwocgNNCpZ8IXo8nVpw9AI5iD95nHirVF5klbto3C8koOvfg4Ep01H14r9u14EWTl3pXZ83VuC6ViOXa9Lt8MdeRMxTz0QbIzYayDmzECVmACH5Gyg1Q4SFB+HIJOAhPKDB7Zue0VDR2HcAdfMaqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G6ffejGG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G6ffejGG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773325682; x=1804861682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yq2ezdncoeCesXuhqcd/gqDzmwVwnT93JTqn7ydj8CE=;
  b=G6ffejGGC68DqFXfZZpDi4lsIZqAGxyGah0n1EgawW2uyaWR1qdI8Tzg
   x4dM9hlM4eVOMrLEvuFDxkePAFiKT4Pp5TO65eQC2smc8ANV2jkNnzqRk
   5Q7Fk4RqSPjuoactNFj0PFNJrpt3qGN3c27B7otYDIlU4vb2eLcQ+5pQe
   tokTL8i5HmeYUH0T8kOdF4GfuOV6qCXM/Js1JauLTWORa4Z4YGg4YHcjw
   R9UTEgTT6do7epWOnCP4CWuyPAuwjgtwxmf7tatAzhlYlfKFxh2py+Set
   E/bBxfPge0/0BRbatEPtX94Ifmmfhp/xv7/66m87kcco1vHYj+FikjqY7
   w==;
X-CSE-ConnectionGUID: Fnve2hfQS7KkjBcbtTdo0w==
X-CSE-MsgGUID: 7VbFCCIkT/ijgm1v07uDXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74531179"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="74531179"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 07:28:02 -0700
X-CSE-ConnectionGUID: mmhDK+IaQfqsJXC+3BnDbA==
X-CSE-MsgGUID: yTu3Z4UjTH27okxffbMqMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="251330637"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 07:27:59 -0700
Date: Thu, 12 Mar 2026 16:27:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Siratul Islam <email@sirat.me>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: proximity: add driver for ST VL53L1X ToF
 sensor
Message-ID: <abLNbGUmaA7K0s68@ashevche-desk.local>
References: <20260311224044.21480-1-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311224044.21480-1-email@sirat.me>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 12, 2026 at 04:40:35AM +0600, Siratul Islam wrote:
> This series adds support for the STMicroelectronics VL53L1X
> Time-of-Flight ranging sensor.
> 
> The VL53L1X is a ToF laser-ranging sensor with I2C interface,
> capable of measuring distances up to 4 meters. The driver
> supports both interrupt-driven and polled operation.
> 
> Why a separate driver is needed (instead of extending vl53l0x-i2c.c):
> The VL53L1X is fundamentally different from the VL53L0X despite the
> similar naming. Extending the existing driver would require rewriting
> the majority of it.

> Key differences include:
> - A different register map (16-bit addresses vs. 8-bit addresses).
> - Requires a 91-byte firmware configuration blob to be loaded at boot.
> - Requires a VHV calibration cycle.
> - Has distance mode and timing budget configurations.
> - Uses the regmap API rather than raw i2c_smbus calls.
> 
> I also reviewed other drivers in drivers/iio/proximity/ and can
> confirm this IP block does not appear to be shared by any other
> existing driver.

> ---
> Changes in v3:
> - Merge DT binding into existing st,vl53l0x.yaml (per Krzysztof).
> - Use "reset-gpios" in the binding but xshut_gpio in the driver since that's the actual pin name.

But why is it "reset" in the bindings? If it's a power rail or enable pin, why
not call it as a such in the bindings? The connection on PCB level is different story.

> - Replace manual polling loops in chip_init and read_proximity with regmap_read_poll_timeout().
> - Remove irq_get_trigger_type() and pass IRQF_NO_THREAD directly (per Andy).
> - Drop struct i2c_client from private data and store irq as int instead. Derive struct device from regmap where needed.
> - Add dev_err_probe() to first devm_request_irq() error path.
> - Replace linux/device.h with linux/dev_printk.h, add linux/array_size.h, linux/err.h, linux/types.h (per Andy).
> - Use USEC_PER_MSEC for poll timeouts.
> - Remove unnecessary casts.
> - Divide long config blob to 8 values per line.
> - Rename goto label to notify_and_clear_irq and drop unused dev_dbg.
> - Add datasheet section reference for boot delay comment.
> - vdd-supply no longer required in shared binding to avoid breaking existing st,vl53l0x devicetrees.

-- 
With Best Regards,
Andy Shevchenko


