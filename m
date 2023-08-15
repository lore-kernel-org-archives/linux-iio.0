Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C333C41513
	for <linux-iio@archiver.kernel.org>; Tue, 15 Aug 2023 14:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbjHOO5U (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 15 Aug 2023 10:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237558AbjHOO4p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Aug 2023 10:56:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E512BE6B;
        Tue, 15 Aug 2023 07:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692111404; x=1723647404;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XXo3sz+mFRNGA11E4wYdBpJxSd47MXqkcrpQIJGqJXk=;
  b=RP7o/eGZfqwhFQDbyeDyHuyCFRLrhn9sY1jJK1ETwDmTSnxmva9u5KeM
   NeotbZGfv+1NfDwRDChKIxEOXpHMXNYLOQtQ08xp+1QgnLeyEd8InafyW
   UT0JZ7GPWG6hcfcsW5DyOXTlNbHc8Vhom+B7MVMpr34Toj5msM7I+B9vY
   j3YzOQl5lCq+qsvfS3tWAD5/yt95ZqUxzEWUH0FWq72Wc9v1VnMXeF3EP
   L8msPu+nq/HA0XwfH3zVkGn1dA9NaXtTgfctywcvijP0EpPR3LNb4l6/W
   SA1LdzPD2jwbtSZ9tSRcLH1OY6N8wzK857qi+c0wLJFUK2I04QwqVkUlS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="438632443"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="438632443"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 07:56:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="733872171"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="733872171"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2023 07:56:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVvTJ-006BvE-2R;
        Tue, 15 Aug 2023 17:56:37 +0300
Date:   Tue, 15 Aug 2023 17:56:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/6] iio: adc: mcp3911: avoid ambiguity parameters in
 macros
Message-ID: <ZNuSJTjOL1sEnVUd@smile.fi.intel.com>
References: <20230814121010.184842-1-marcus.folkesson@gmail.com>
 <20230814121010.184842-5-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814121010.184842-5-marcus.folkesson@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 14, 2023 at 02:10:09PM +0200, Marcus Folkesson wrote:
> Name macro parameters after what they represent instead of 'x'.

Yes, but it's not my suggestion, what I was talking about is how macro
parameters being treated.

This change doesn't make the problem go away.

Per se, this one is good for its purposes.

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This shouldn't be here.

-- 
With Best Regards,
Andy Shevchenko


