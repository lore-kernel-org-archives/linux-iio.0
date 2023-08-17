Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590FAC2FC14
	for <linux-iio@archiver.kernel.org>; Thu, 17 Aug 2023 12:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350885AbjHQMm4 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 17 Aug 2023 08:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350841AbjHQMm3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Aug 2023 08:42:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3562D57;
        Thu, 17 Aug 2023 05:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692276149; x=1723812149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rnvQB8vVYEWmrqyik5H2iI+pxyd4YqSM4HtPDho3t3M=;
  b=HBBJSyVZ2C8OmKI16GxEoneJRJiLVxLDrBe7cBPIIkd4DZlRSA16a3By
   3C3TqabwtZOgBNBWhR5wjZB2CWHZnDDvrIBLEUiP+FbT/fHYwbCIaW8mm
   GTXCMxWF5rknIZ3zKndI8Qrzok9540eGvws6V541ogLGUfZC77fPXDlOH
   XCI+3y+7ohqZR6f/WJCrYzqqQp2kyNuq9JZ7MLP3dwJJbShxcubrdthZh
   ZlmdXIc9fNADwcHw/ADXorKf7GEjwNWAAgwaDp8IoluZTsOfto3pf1Vmz
   CTqnhbGXIZFESktPVQpf0dMYqGgB7/aFeYtwmFiJOFxQr73M5FdoeOVU2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436702380"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="436702380"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 05:42:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="764063865"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="764063865"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2023 05:42:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWcKS-00Bpg4-3D;
        Thu, 17 Aug 2023 15:42:21 +0300
Date:   Thu, 17 Aug 2023 15:42:20 +0300
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
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 1/6] dt-bindings: iio: adc: mcp3911: add support for
 the whole MCP39xx family
Message-ID: <ZN4VrLPKhQIVLxfP@smile.fi.intel.com>
References: <20230817120518.153728-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817120518.153728-1-marcus.folkesson@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 17, 2023 at 02:05:13PM +0200, Marcus Folkesson wrote:
> Microchip does have many similar chips, add those to the compatible
> string as the driver support is extended.

With properly formed cover letter (and using --base) a maintainer may safe
their time by utilizing some features of `b4`. I.e. the

	b4 -slt -M ...

will treat the series as a PR with summary in cover letter taking into merge
commit. This is really cool feature and from now on I will require people to
submit the series with mandatory cover-letter and --base in use.

BUT. I'm not the maintainer here, so up to Jonathan to decide.

-- 
With Best Regards,
Andy Shevchenko


