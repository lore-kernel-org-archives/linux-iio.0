Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDAB3DD533;
	Thu,  3 Sep 2026 06:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788416320; cv=none; b=KsK55kppk9SAblLoa+cYub9qT4TfJhq5mObJ9itIaJJFu6w+YhnhpdmH3s0z5rYxshEydSfPcOTU2uVwC+NX+mjM0IWuCvgupKu3vrye/mpX//4jdI95PdaHRPKnmBRO0JFbpewy8Oh3tzP76hL157f9Z0f9Fi/APJ6zPZ6CwCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788416320; c=relaxed/simple;
	bh=mpft1NnwMVq1t5m6FqgL2KE/iQcOvbcNiKDdqOq2htg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1ACy7vf+6JK4rkXkrd+KVQZf/rSXW89iklt/9MyxPVLkh7dxO3FTcgu+Ua652pH4eMHrB5tkMf1dXVLpus2ZxhijwFgWELQLwysWtBuRMssU8mu8ZRNnJOXkNBL2oXQgXLkpji4QHS8jr2r7PNS/fNj19x8wg2wLhsfx3KIdHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OeX4HiEo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OeX4HiEo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788416319; x=1819952319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mpft1NnwMVq1t5m6FqgL2KE/iQcOvbcNiKDdqOq2htg=;
  b=OeX4HiEoHl5PwmQt9MCqtzIs82xmYXll08SKfPcy81e+RNV1iL3pcGFP
   XeiThOgfvJQ2cGNzVsbnEOFt6b3kACUqbbD7rUmedMBi/HVHeuAzyA9hI
   /GjjmWr9sCuItca73gg5bmfkJVKexr58Vmh3L9z/zS2vAxhfYLnZKQu50
   RrWESRBtlkXvHSk97kiDBNhDAQG2LASbYpttGEypbioynXqiaj5YYny08
   uPMjAZnzINu5N0XxqZmzhia+wstoCWRaHLbqegy38dk+CUeQOYuGxR6Qv
   bIf3r84/zyQCMobR4zwCVzqlpN9Ijg8BNwn3RLG4h5wwtiUbo5jBaQCmX
   Q==;
X-CSE-ConnectionGUID: msWbhw8QTQuX+syH1909ig==
X-CSE-MsgGUID: Zi/4pw1HTfK+HGXviu8k3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="92705480"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="92705480"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:18:20 -0700
X-CSE-ConnectionGUID: 38Bw4+YVRE2OE0iv/qoExQ==
X-CSE-MsgGUID: Iuc2Jm7ZTxuGC3iEosd2Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="268292423"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:18:17 -0700
Date: Thu, 3 Sep 2026 09:18:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Flaviu Nistor <flaviu.nistor@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads1015: Add support for label
Message-ID: <apkRJ8T-X-HoNiDB@ashevche-desk.local>
References: <20260902172230.5234-1-flaviu.nistor@gmail.com>
 <20260902172230.5234-2-flaviu.nistor@gmail.com>
 <cf9a0918-3e06-4532-8e72-ccc4d417e6b2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf9a0918-3e06-4532-8e72-ccc4d417e6b2@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 02, 2026 at 01:37:45PM -0500, David Lechner wrote:
> On 9/2/26 12:22 PM, Flaviu Nistor wrote:

...

> > +		if (fwnode_property_present(node, "label")) {
> > +			ret = fwnode_property_read_string(node, "label", &label);
> > +			if (ret) {
> > +				dev_err(dev, "invalid label on %pfw\n", node);
> > +				return ret;

				return dev_err_probe(...);

> > +			}
> > +			data->channel_data[channel].label = label;
> > +		} else {
> > +			data->channel_data[channel].label = "";
> 
> I think the normal way to do this is to return -EINVAL on channels with no
> label rather than an empty string.


In this case the whole dance with property_present is not required.
(What you are saying sounds like label is mandatory property, but
 how the old DT will work that have no such property?)

> > +		}

-- 
With Best Regards,
Andy Shevchenko


