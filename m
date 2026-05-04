Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFB81519B4;
	Mon,  4 May 2026 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777890337; cv=none; b=eFiFquIWyQPA8aL96oxVP9fEmwI+2pNAuwfp6j5Qsca1RR0ztCU9Ahkhj+ruaeQnPfwkejmO4E99GdweLrVhNDonvBFv7eFuejo8o64ALWeUNGTVDN3vXxf1fiV9ONj20IMfdatQXQqFkNZ2MDe8r0QmqCehA6XW92a6zPGAE18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777890337; c=relaxed/simple;
	bh=nluvpIlNryhcGDtvNGYTLW0ZG88gXOfoCaYP2s86tRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2pt4Xlkd2ChXUoTIRPxmCDBZSay6qPd23sJfnT1z+K/tdi+ei03DYZXdKa3zfidB2LCqPdQqs5yH57ztsGhjaeHquhe6z+K589Kj69tvSvaOtPcS8ujLo4m3oJew53qfqQJt7mX8xnSmEuajq3HF135qaJK+v3rdfinGknDvmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DrsKIhRE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DrsKIhRE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777890335; x=1809426335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nluvpIlNryhcGDtvNGYTLW0ZG88gXOfoCaYP2s86tRE=;
  b=DrsKIhRE1ZHK67cW9cSFnEoPyOlDX9PYag5TbPPABZ68eogHgbaVoB3+
   erCYaG8iPpoDQjgPJMfjR5F1zkbdFeDg9xB3W36feaoIXI3k52dMStsik
   tmJDci8r6o9u/7hJtGJtMpZA767UTNDFa2vajqQdt+WKao35mG7wRvP4k
   9DBc6mJAhQYfBsSexwANoFa8anbUOD2g2BosqMn631G4mshV0aiftot0y
   IZHkvm9aZlCc+rYsCreHRDTGyGGxIcM+wDmaUyF2UI3maMEXGJaSFaRD/
   Ak3DZUhfYiqwtMH2/JRtZk/b++qv4wpmla3pEic/f317LH/ieain8vVNd
   A==;
X-CSE-ConnectionGUID: mVB+jOmaRuWCSBRHv8T/Ow==
X-CSE-MsgGUID: r33sDnpVS/KR4Fjrfft96Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="81311365"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="81311365"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 03:25:35 -0700
X-CSE-ConnectionGUID: Npkc06voSSmxkmSJ60YSug==
X-CSE-MsgGUID: BjbfiXUfRIq+PdsmQSg8HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="232826942"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 03:25:32 -0700
Date: Mon, 4 May 2026 13:25:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salih Erim <salih.erim@amd.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, git@amd.com, nuno.sa@analog.com,
	andy@kernel.org, dlechner@baylibre.com, michal.simek@amd.com,
	conall.ogriofa@amd.com, erimsalih@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] iio: adc: versal-sysmon: add I2C driver
Message-ID: <afh0GW_SXuq72KwJ@ashevche-desk.local>
References: <20260502111951.538488-1-salih.erim@amd.com>
 <20260502111951.538488-4-salih.erim@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260502111951.538488-4-salih.erim@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, May 02, 2026 at 12:19:49PM +0100, Salih Erim wrote:
> Add I2C bus driver for Versal SysMon to enable voltage and temperature
> monitoring when the Versal chip has SysMon configured with an I2C
> interface.
> 
> The I2C protocol uses a custom 8-byte write format:
>   - Bytes 0-3: Data (little-endian, 32-bit)
>   - Bytes 4-5: Register offset (split into low/high parts)
>   - Byte 6: Instruction (read=0x4, write=0x8)
>   - Byte 7: Reserved
> 
> For reads, the driver sends the 8-byte command then receives 4 bytes
> of data. For writes, it sends the 8-byte command with embedded data.
> 
> The driver uses the regmap API with custom read/write callbacks to
> share the bus-agnostic core driver (versal-sysmon-core).
> 
> Event support is not available on I2C since the SysMon interrupt
> lines are not routed over the I2C bus.

...

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>

Follow IWYU.

...

> +enum sysmon_i2c_payload_idx {
> +	SYSMON_I2C_DATA0_IDX = 0,

Is it mapped to HW bits or is it pure Linux enum? If the former, assign *all*
items as per datasheet, otherwise drop explicit assignment (it's rare that we
need it in the software).

> +	SYSMON_I2C_DATA1_IDX,
> +	SYSMON_I2C_DATA2_IDX,
> +	SYSMON_I2C_DATA3_IDX,
> +	SYSMON_I2C_OFS_LOW_IDX,
> +	SYSMON_I2C_OFS_HIGH_IDX,
> +	SYSMON_I2C_INSTR_IDX,
> +};

...

> +struct sysmon_i2c {
> +	struct i2c_client *client;
> +};

Can't be the struct i2c_client used directly? (Haven't checked if this is going
to be extended or have special uses.

...

> +static int sysmon_i2c_reg_read(void *context, unsigned int reg,
> +			       unsigned int *val)
> +{
> +	u8 write_buf[SYSMON_I2C_WRITE_SIZE] = { 0 };
> +	u8 read_buf[SYSMON_I2C_READ_SIZE];
> +	struct sysmon_i2c *priv = context;
> +	int ret;
> +
> +	write_buf[SYSMON_I2C_OFS_LOW_IDX] =
> +		FIELD_GET(SYSMON_I2C_OFS_LOW_MASK, reg);
> +	write_buf[SYSMON_I2C_OFS_HIGH_IDX] =
> +		FIELD_GET(SYSMON_I2C_OFS_HIGH_MASK, reg);
> +	write_buf[SYSMON_I2C_INSTR_IDX] = SYSMON_I2C_INSTR_READ;
> +
> +	ret = i2c_master_send(priv->client, write_buf, SYSMON_I2C_WRITE_SIZE);

sizeof()

> +	if (ret < 0)
> +		return ret;
> +	if (ret != SYSMON_I2C_WRITE_SIZE)

sizeof()

> +		return -EIO;
> +
> +	ret = i2c_master_recv(priv->client, read_buf, SYSMON_I2C_READ_SIZE);

sizeof()

> +	if (ret < 0)
> +		return ret;
> +	if (ret != SYSMON_I2C_READ_SIZE)

sizeof()

With them the code will have one source of length an be robust to the changes
of the buffer sizes.

> +		return -EIO;
> +
> +	*val = FIELD_PREP(SYSMON_I2C_DATA0_MASK,
> +			  read_buf[SYSMON_I2C_DATA0_IDX]) |
> +	       FIELD_PREP(SYSMON_I2C_DATA1_MASK,
> +			  read_buf[SYSMON_I2C_DATA1_IDX]) |
> +	       FIELD_PREP(SYSMON_I2C_DATA2_MASK,
> +			  read_buf[SYSMON_I2C_DATA2_IDX]) |
> +	       FIELD_PREP(SYSMON_I2C_DATA3_MASK,
> +			  read_buf[SYSMON_I2C_DATA3_IDX]);
> +
> +	return 0;
> +}

...

> +static int sysmon_i2c_reg_write(void *context, unsigned int reg,
> +				unsigned int val)
> +{
> +	u8 write_buf[SYSMON_I2C_WRITE_SIZE] = { 0 };

'0' is redundant.

> +	struct sysmon_i2c *priv = context;
> +	int ret;
> +
> +	write_buf[SYSMON_I2C_DATA0_IDX] =
> +		FIELD_GET(SYSMON_I2C_DATA0_MASK, val);
> +	write_buf[SYSMON_I2C_DATA1_IDX] =
> +		FIELD_GET(SYSMON_I2C_DATA1_MASK, val);
> +	write_buf[SYSMON_I2C_DATA2_IDX] =
> +		FIELD_GET(SYSMON_I2C_DATA2_MASK, val);
> +	write_buf[SYSMON_I2C_DATA3_IDX] =
> +		FIELD_GET(SYSMON_I2C_DATA3_MASK, val);
> +	write_buf[SYSMON_I2C_OFS_LOW_IDX] =
> +		FIELD_GET(SYSMON_I2C_OFS_LOW_MASK, reg);
> +	write_buf[SYSMON_I2C_OFS_HIGH_IDX] =
> +		FIELD_GET(SYSMON_I2C_OFS_HIGH_MASK, reg);
> +	write_buf[SYSMON_I2C_INSTR_IDX] = SYSMON_I2C_INSTR_WRITE;

> +	ret = i2c_master_send(priv->client, write_buf, SYSMON_I2C_WRITE_SIZE);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != SYSMON_I2C_WRITE_SIZE)
> +		return -EIO;

sizeof() in both cases.

> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


