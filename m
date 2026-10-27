Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089277;
	b=vEGWsxU3xWE31zr6+BkksHrAFIbZhKVossLOFxbNBRkvGUxTAjYt3ymnd7/E/JXytggp
	 5nmL8BP4NvM5mOX/deEWURY6c6GIaoXLkrHxgBN8AxkvCrwHx53+kCfuWik0IJgG3To4L
	 7I3a9rJBV6+Odtk1Mo71+rro2WtConm6zK9QA5DAR176O0ZgVTNMQJ+X4umlBWk5QHrKe
	 /2R2aeOL3+enrZpxcLSrH8Cdf4NWcB9whahpNqr+6WsDfWtE+JafTrU5HUpXhlv87GzL2
	 9EKEkGyY0ii5eDYtJNR/MgQnOBKl+uTXSgkcQVWl+BbXvPNFHl22O1Aem8/vKR077nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089277;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=jXudob4FNwiWo3hKeRI2goSq7uyjjvjV5QYY8az2u1I=;
	b=Gwryxgzq63bNFgYMGWjm4Rc54quExQumIvIkLJ65vqkjmGTwnwxlUd6MT5CWoCdVqops
	 P0Nk0sbVW1SlHSQDJFV8IFnBmB8/GJgS/Y1SAdMwkCZMr85jT4Vi8gTeyD9YdOv460CcC
	 yeVRyGWamWn635+ChsEAbcyY02ZMGEJt4cNvrsCue96AVYb5JBvpf6gHAIyahdqqkpb1d
	 Ao01x2gwfbpQ/JyQ9/bL82ZTZLSUnD9YigmarYhG5JDX1Zli8JG7iLwwHLMkzuKmp77V1
	 uFMwLM0kVDqcn4qLjFlvb83F/bFdQn8uXmOG356xJMaDHshXoTKRGfvIx/6DhIsCN/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NJDSf8Ts;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F842606A31B
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 08:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F842606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NJDSf8Ts
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793089276; x=1824625276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XiDkEh7B3Izv8UXVNWN+A7npyoKvcNWJC5jYfCpWRGU=;
  b=NJDSf8TshkZLWCyTMm+ab69xwgy45PfeTJlnWEQTkj99G2kfZ7tgUrd5
   bHYvEIAMGePyIgsyIeZVw1wzAciYHSZyKvsLfwAtGjYdlPJlKJKEBv2ID
   wKgdeLJ6b5vWL5Os7TvG7lwemJqV/jELRtQlS/EtKUsHwtiope2w563nu
   tg6CLrjFBe38Qn0SGRWl2Mh2HgsyfvBIfD4rR6hdZLTHBjzRqkh1vmZ3a
   +xMVt8+cE16yACLYmdVMPVx306d8dLcaVOm0VoAsiqHZpRCKV65NY5TpD
   Bs8/0dYuKd1yT/YZgF/FAAOHI1u7xh3H1JW4aTfNV4aCOfB5caVUF3yuy
   Q==;
X-CSE-ConnectionGUID: jIn1U4fRRA2UVaS6FhE/hw==
X-CSE-MsgGUID: AcAodntwSrmqmabpQqEikQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1776599"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1776599"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:21:15 -0700
X-CSE-ConnectionGUID: T0OskXOZQWacvSVk2bu7EQ==
X-CSE-MsgGUID: mzH7Zn42QAijCoDNpaI+zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4570073"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:21:13 -0700
Date: Tue, 27 Oct 2026 10:21:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Lixu <lixu.zhang@intel.com>
Subject: Re: [PATCH 05/39] iio: hid-sensors: use iio_push_to_buffers_with_ts()
Message-ID: <auBe99wrAxb-Bc6H@ashevche-desk.local>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
 <20261026-iio-v1-5-8b136778eedf@oss.qualcomm.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-iio-v1-5-8b136778eedf@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 04:05:23PM -0700, Jonathan Cameron wrote:
> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
> 
> For hid-sensor-magn-3d, use IIO_DECLARE_BUFFER_WITH_TS() to suize the
> buffer for the maximum number of channels supported avoiding need
> for separate allocation.

I was staring at this for a while. The feeling is that it has to work
as we don't register more channels than it was reported by the HW.
Since the patch makes the buffer static of maximum size, the _with_ts()
should handle this correctly.

But it would be nice to check, indeed.

-- 
With Best Regards,
Andy Shevchenko


