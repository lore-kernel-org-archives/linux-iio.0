Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D014D256C8B;
	Sat, 14 Feb 2026 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771086861; cv=none; b=dWgvC7FxIXSHTcj3ii6btHCKKWX86KILtsxPJUjoGnKdYVlkP6FqydI11dsae5ESXicvWuER9jjQmZdMzNh3Lc0PTAzDxOgSujmMKK+6/JrL/TvxUFtfVnsdukjrUDQ0COsS3zjapDfinr1R1JI6FSK30UrAj9K8OuHc8cABqHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771086861; c=relaxed/simple;
	bh=aaJHONTVu1oBYbCd11xREYrlOSzzyzHYma5hnZpqe9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFYJE39C9X0/hTGq+uePJRbsd8NDdhD1kuuAD0JCQ2jrXQbfp4GRyL/gNOEjn77XgExYrM59DCUtulIWZdZUtsHH2bEQNq+uztYgBTz260HKEoqbQMOJJ997M8yRIOx+CyoB259eeALKEuXnGjVr2G8Sqjud0/8iOM1GjY7wpLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uiixixvj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiixixvj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160A5C16AAE;
	Sat, 14 Feb 2026 16:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771086861;
	bh=aaJHONTVu1oBYbCd11xREYrlOSzzyzHYma5hnZpqe9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uiixixvjfyZUywwd4LsU06qUaHcwnGpvKKuOWxzMgc1WZrYtkpsaYE6rkvbSbPJ63
	 XjSRimOip65ufXWe6Vl7gPMcQaCDUMtGeRc4MBGvq3RqtnVDTsSggTIMYOL1ulWocy
	 Tk5E02MZahnusuQmN90ZgDqco8zD+2+xywuB9u8ja2XcypLst5jJY6Xb920FEM4kfq
	 nxRV869gP96Oa1Psr0nwGYAIKL2JNq2wgdSbNOGXMBQg0Ilf5V3IY0YNBLThxHrLiB
	 qdt+R13V4URXp1zBpwPbukoiyMEeWEhPRWbt1Z84JRdh3fRdpQnaQ8LYj5P8g/Szsu
	 0a1Tp4/Qf03xQ==
Date: Sat, 14 Feb 2026 16:34:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Neel Bullywon <neelb2403@gmail.com>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] iio: magnetometer: bmc150_magn: use automated
 cleanup for mutex
Message-ID: <20260214163412.1039fdd9@jic23-huawei>
In-Reply-To: <202602140708.3KGC8ZJJ-lkp@intel.com>
References: <20260210233945.40975-2-neelb2403@gmail.com>
	<202602140708.3KGC8ZJJ-lkp@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Feb 2026 07:31:03 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Neel,
> 
> kernel test robot noticed the following build errors:

Just replying to this to highlight what I the whole scope thing is about.

> 
> [auto build test ERROR on e7aa57247700733e52a8e2e4dee6a52c2a76de02]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Neel-Bullywon/iio-magnetometer-bmc150_magn-use-automated-cleanup-for-mutex/20260211-074324
> base:   e7aa57247700733e52a8e2e4dee6a52c2a76de02
> patch link:    https://lore.kernel.org/r/20260210233945.40975-2-neelb2403%40gmail.com
> patch subject: [PATCH v6 1/3] iio: magnetometer: bmc150_magn: use automated cleanup for mutex
> config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20260214/202602140708.3KGC8ZJJ-lkp@intel.com/config)
> compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260214/202602140708.3KGC8ZJJ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202602140708.3KGC8ZJJ-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/iio/magnetometer/bmc150_magn.c:561:2: error: cannot jump from switch statement to this case label  
>      561 |         default:
>          |         ^
>    drivers/iio/magnetometer/bmc150_magn.c:527:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
>      527 |                 guard(mutex)(&data->mutex);
>          |                 ^
>    include/linux/cleanup.h:414:15: note: expanded from macro 'guard'
>      414 |         CLASS(_name, __UNIQUE_ID(guard))
>          |                      ^
>    include/linux/compiler.h:168:2: note: expanded from macro '__UNIQUE_ID'
>      168 |         __PASTE(__UNIQUE_ID_,                                   \
>          |         ^
>    include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
>       16 | #define __PASTE(a, b) ___PASTE(a, b)
>          |                       ^
>    include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
>       15 | #define ___PASTE(a, b) a##b
>          |                        ^
>    <scratch space>:122:1: note: expanded from here
>      122 | __UNIQUE_ID_guard_677
>          | ^
>    drivers/iio/magnetometer/bmc150_magn.c:529:2: error: cannot jump from switch statement to this case label
>      529 |         case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>          |         ^
>    drivers/iio/magnetometer/bmc150_magn.c:527:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
>      527 |                 guard(mutex)(&data->mutex);
>          |                 ^
>    include/linux/cleanup.h:414:15: note: expanded from macro 'guard'
>      414 |         CLASS(_name, __UNIQUE_ID(guard))
>          |                      ^
>    include/linux/compiler.h:168:2: note: expanded from macro '__UNIQUE_ID'
>      168 |         __PASTE(__UNIQUE_ID_,                                   \
>          |         ^
>    include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
>       16 | #define __PASTE(a, b) ___PASTE(a, b)
>          |                       ^
>    include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
>       15 | #define ___PASTE(a, b) a##b
>          |                        ^
>    <scratch space>:122:1: note: expanded from here
>      122 | __UNIQUE_ID_guard_677
>          | ^
>    2 errors generated.
> 
> 
> vim +561 drivers/iio/magnetometer/bmc150_magn.c
> 
> c91746a2361d75 Irina Tirdea   2015-04-29  515  
> c91746a2361d75 Irina Tirdea   2015-04-29  516  static int bmc150_magn_write_raw(struct iio_dev *indio_dev,
> c91746a2361d75 Irina Tirdea   2015-04-29  517  				 struct iio_chan_spec const *chan,
> c91746a2361d75 Irina Tirdea   2015-04-29  518  				 int val, int val2, long mask)
> c91746a2361d75 Irina Tirdea   2015-04-29  519  {
> c91746a2361d75 Irina Tirdea   2015-04-29  520  	struct bmc150_magn_data *data = iio_priv(indio_dev);
> c91746a2361d75 Irina Tirdea   2015-04-29  521  	int ret;
> c91746a2361d75 Irina Tirdea   2015-04-29  522  
> c91746a2361d75 Irina Tirdea   2015-04-29  523  	switch (mask) {
> c91746a2361d75 Irina Tirdea   2015-04-29  524  	case IIO_CHAN_INFO_SAMP_FREQ:
> 5990dc9703679a Irina Tirdea   2015-04-29  525  		if (val > data->max_odr)
> 5990dc9703679a Irina Tirdea   2015-04-29  526  			return -EINVAL;
> d65a37daae6aa8 Neel Bullywon  2026-02-10  527  		guard(mutex)(&data->mutex);

It's hard to spot from the error message, but here is the bug.  This is in the same
scope as default label below that is hightlighted.
Thus wonderfully the __free() that hides under the guard() magic is
initialized but because we don't go down this path to reach that
default, we can the __free() (ultimately mutex_unlock())
on an unassigned pointer.

Hence scope for these really matters!

Jonathan


> d65a37daae6aa8 Neel Bullywon  2026-02-10  528  		return bmc150_magn_set_odr(data, val);
> 5990dc9703679a Irina Tirdea   2015-04-29  529  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> 5990dc9703679a Irina Tirdea   2015-04-29  530  		switch (chan->channel2) {
> 5990dc9703679a Irina Tirdea   2015-04-29  531  		case IIO_MOD_X:
> 5990dc9703679a Irina Tirdea   2015-04-29  532  		case IIO_MOD_Y:
> 5990dc9703679a Irina Tirdea   2015-04-29  533  			if (val < 1 || val > 511)
> 5990dc9703679a Irina Tirdea   2015-04-29  534  				return -EINVAL;
> d65a37daae6aa8 Neel Bullywon  2026-02-10  535  			{
> d65a37daae6aa8 Neel Bullywon  2026-02-10  536  				guard(mutex)(&data->mutex);
> 5990dc9703679a Irina Tirdea   2015-04-29  537  				ret = bmc150_magn_set_max_odr(data, val, 0, 0);
> d65a37daae6aa8 Neel Bullywon  2026-02-10  538  				if (ret < 0)
> 5990dc9703679a Irina Tirdea   2015-04-29  539  					return ret;
> d65a37daae6aa8 Neel Bullywon  2026-02-10  540  				return regmap_update_bits(data->regmap,
> 5990dc9703679a Irina Tirdea   2015-04-29  541  							 BMC150_MAGN_REG_REP_XY,
> 1506f3cd0b8169 Hartmut Knaack 2015-07-17  542  							 BMC150_MAGN_REG_REP_DATAMASK,
> d65a37daae6aa8 Neel Bullywon  2026-02-10  543  							 BMC150_MAGN_REPXY_TO_REGVAL(val));
> d65a37daae6aa8 Neel Bullywon  2026-02-10  544  			}
> 5990dc9703679a Irina Tirdea   2015-04-29  545  		case IIO_MOD_Z:
> 5990dc9703679a Irina Tirdea   2015-04-29  546  			if (val < 1 || val > 256)
> 5990dc9703679a Irina Tirdea   2015-04-29  547  				return -EINVAL;
> d65a37daae6aa8 Neel Bullywon  2026-02-10  548  			{
> d65a37daae6aa8 Neel Bullywon  2026-02-10  549  				guard(mutex)(&data->mutex);
> 5990dc9703679a Irina Tirdea   2015-04-29  550  				ret = bmc150_magn_set_max_odr(data, 0, val, 0);
> d65a37daae6aa8 Neel Bullywon  2026-02-10  551  				if (ret < 0)
> 5990dc9703679a Irina Tirdea   2015-04-29  552  					return ret;
> d65a37daae6aa8 Neel Bullywon  2026-02-10  553  				return regmap_update_bits(data->regmap,
> 5990dc9703679a Irina Tirdea   2015-04-29  554  							 BMC150_MAGN_REG_REP_Z,
> 1506f3cd0b8169 Hartmut Knaack 2015-07-17  555  							 BMC150_MAGN_REG_REP_DATAMASK,
> d65a37daae6aa8 Neel Bullywon  2026-02-10  556  							 BMC150_MAGN_REPZ_TO_REGVAL(val));
> d65a37daae6aa8 Neel Bullywon  2026-02-10  557  			}
> 5990dc9703679a Irina Tirdea   2015-04-29  558  		default:
> 5990dc9703679a Irina Tirdea   2015-04-29  559  			return -EINVAL;
> 5990dc9703679a Irina Tirdea   2015-04-29  560  		}
> c91746a2361d75 Irina Tirdea   2015-04-29 @561  	default:
> c91746a2361d75 Irina Tirdea   2015-04-29  562  		return -EINVAL;
> c91746a2361d75 Irina Tirdea   2015-04-29  563  	}
> c91746a2361d75 Irina Tirdea   2015-04-29  564  }
> c91746a2361d75 Irina Tirdea   2015-04-29  565  
> 

