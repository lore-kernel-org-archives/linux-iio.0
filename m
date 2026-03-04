Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8513DA5D9;
	Wed,  4 Mar 2026 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652395; cv=none; b=mfIzRRblnbBtmO8ZIXNxq6GrBiMA3A1ZV8bq9q8QzV+a3TGVq3kjKOgQVYUKzZ3yd8cuKQEokqQh83bVooe2d95HJmQIJfBra6FOJvExIh7Fq7WCRG2ip8k3fI/ObrErYmZ2N33U4DEdkYZaHGE04c0PPdAyMzTg8hq8LFdqWvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652395; c=relaxed/simple;
	bh=N9ShbZ+x93nC9UT07joStraHI9n0cnfEIL2rQPrh5I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgOglJvFJJg2LvNDhdw6FrArUe8O1x06UlvfPNHpxT10Q5AypgM45kFcIq9ZGFBNDemkOZXgCYZMN1jA3ptFHQDvzliOh5ShV2I3ui/L/Rb1Ar7CyuAqdEMoDjVnaMGCL5wpa7PZKS0/MfYqHbYxhO+5a3QY4EMkAHu2oKrJhrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iw/lEoPM; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iw/lEoPM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772652394; x=1804188394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N9ShbZ+x93nC9UT07joStraHI9n0cnfEIL2rQPrh5I8=;
  b=Iw/lEoPMAuvuwCqWnFd24wuWYg6/cAkTEqsdKb7m1Et0eyXRz2VSoz5/
   EPctLwycY8LGc0HFFd37UbX91zi/+Eh6cC3JHVZ06Pq5DviX+GCXepWQc
   dwJ6RqSDdHWC71LlM+qH9CyjXHA28qnc4l7fJV0uCqV0UJVRBH9fZ7lDD
   YrhLtyZ4feJw8Ov0SDptqm0yxfK+A8IJOounpIjOh5Y/dDFTCemtdMfU/
   AMr7ErEdLUW4tWlUNrtnzEYHVdBRZdukoN8A+AXUk5yemiyuWScqGR1Bg
   T1isCq8aeCPqtatoXzIxA5WgKw1zqzNzmctQbJKgSFuFtJw3fN/gN2Gx9
   g==;
X-CSE-ConnectionGUID: 6lKYcFyLSEe9hL0wXX/ZXg==
X-CSE-MsgGUID: lw2a8zr1SDG+nTv9QUR4AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="72753477"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="72753477"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 11:26:34 -0800
X-CSE-ConnectionGUID: gzfGC8paSqa36wJp0DFaUg==
X-CSE-MsgGUID: 6bSA8yIbTnOsa3EscSeRvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="221370862"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa004.fm.intel.com with ESMTP; 04 Mar 2026 11:26:32 -0800
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxrra-000000001lJ-0mC8;
	Wed, 04 Mar 2026 19:26:30 +0000
Date: Wed, 4 Mar 2026 20:25:31 +0100
From: kernel test robot <lkp@intel.com>
To: Francesco Lavra <flavra@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v7 5/6] iio: ABI: Add partial quaternion modifier
Message-ID: <202603042011.WHve1GRB-lkp@intel.com>
References: <20260304080706.2844472-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304080706.2844472-1-flavra@baylibre.com>

Hi Francesco,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20260303]
[also build test WARNING on v7.0-rc2]
[cannot apply to jic23-iio/togreg linus/master v7.0-rc2 v7.0-rc1 v6.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Francesco-Lavra/iio-imu-st_lsm6dsx-Fix-check-for-invalid-samples-from-FIFO/20260304-161927
base:   next-20260303
patch link:    https://lore.kernel.org/r/20260304080706.2844472-1-flavra%40baylibre.com
patch subject: [PATCH v7 5/6] iio: ABI: Add partial quaternion modifier
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
reproduce: (https://download.01.org/0day-ci/archive/20260304/202603042011.WHve1GRB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603042011.WHve1GRB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: tools/docs/documentation-file-ref-check references a file that doesn't exist: Documentation/devicetree/dt-object-internal.txt
   Warning: tools/docs/documentation-file-ref-check references a file that doesn't exist: m,^Documentation/scheduler/sched-pelt
   Warning: tools/docs/documentation-file-ref-check references a file that doesn't exist: m,(Documentation/translations/[
   Using alabaster theme
   Documentation/ABI/testing/sysfs-bus-iio:1758: ERROR: Unexpected indentation. [docutils]
>> Documentation/ABI/testing/sysfs-bus-iio:1758: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
   Documentation/core-api/kref:328: ./include/linux/kref.h:72: WARNING: Invalid C declaration: Expected end of definition. [error at 96]
   int kref_put_mutex (struct kref *kref, void (*release)(struct kref *kref), struct mutex *mutex) __cond_acquires(true# mutex)
   ------------------------------------------------------------------------------------------------^
   Documentation/core-api/kref:328: ./include/linux/kref.h:94: WARNING: Invalid C declaration: Expected end of definition. [error at 92]
   int kref_put_lock (struct kref *kref, void (*release)(struct kref *kref), spinlock_t *lock) __cond_acquires(true# lock)


vim +1758 Documentation/ABI/testing/sysfs-bus-iio

> 1758	What:		/sys/bus/iio/devices/iio:deviceX/in_rot_partial_quaternion_raw
  1759	KernelVersion:	7.1
  1760	Contact:	linux-iio@vger.kernel.org
  1761	Description:
  1762			Raw value of {x, y, z} components of the quaternion vector. These
  1763			components represent the axis about which a rotation occurs, and are
  1764			subject to the following costraints:
  1765			- the quaternion vector is normalized, i.e. x^2 + y^2 + z^2 + w^2 = 1
  1766			- the rotation angle is within the [-180, 180] range, i.e. the w
  1767			  component (which represents the amount of rotation) is non-negative
  1768			These constraints allow the w value to be calculated from the other
  1769			components: w = sqrt(1 - (x^2 + y^2 + z^2)).
  1770	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
