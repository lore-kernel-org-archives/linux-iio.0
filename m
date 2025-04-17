Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996781B6CE5;
	Thu, 17 Apr 2025 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744909215; cv=none; b=Ul7LQiyZvmEnIGWpb5se5mtl2pVmSnQTvvfizIbes7SHhOToJMqSt4YvaQNVHJGvAmzqu28ibCyhnXWAqsji/94T47TGdNudhbD5ivQcu2sNfDP4Zhd1j/Ud1ioWoNA2t46Uqsitn3KZr2lxNNte2PL5rn5/cFaucG7e7tFF6o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744909215; c=relaxed/simple;
	bh=nQCnnuQaayG0AUlt7J4i+7082mcRShYU1zxRcAsQQAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCvlHcBRtmmwQCcMV4+gwvlUNOQ/V2yOzMGWNy0sn0QArfQM+Ay47ETMs707oaRB1GtiN8EPaSPyv8uBcuFZBO9o+bbYDaVz6NDXo12OQcSntLDuMMdhHlEhovEqruer7g//5/rUOKpYCuIdLG8F7xm4NQWUUpAbx4iB3M7HpxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: P5ynM797SXukon4iB6i7Wg==
X-CSE-MsgGUID: OnsjJa3cRs2EI4tz4nhIUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="57896176"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="57896176"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 10:00:13 -0700
X-CSE-ConnectionGUID: rWy/F7c+SyeYPFOo11Ev+g==
X-CSE-MsgGUID: yfwn/Rs9TluKqRcHV1gQ3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="131411561"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 10:00:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u5Sar-0000000DGBj-3VcS;
	Thu, 17 Apr 2025 20:00:05 +0300
Date: Thu, 17 Apr 2025 20:00:05 +0300
From: Andy Shevchenko <andy@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 7/8] iio: imu: inv_mpu6050: align buffer for timestamp
Message-ID: <aAEzlZoZTsQuWgZa@smile.fi.intel.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
 <20250417-iio-more-timestamp-alignment-v1-7-eafac1e22318@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417-iio-more-timestamp-alignment-v1-7-eafac1e22318@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 17, 2025 at 11:52:39AM -0500, David Lechner wrote:
> Align the buffer used with iio_push_to_buffers_with_timestamp() to
> ensure the s64 timestamp is aligned to 8 bytes.

Same question as per previous patch.

-- 
With Best Regards,
Andy Shevchenko


