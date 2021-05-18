Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D10C433ED
	for <linux-iio@archiver.kernel.org>; Tue, 18 May 2021 09:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7C846108D
	for <linux-iio@archiver.kernel.org>; Tue, 18 May 2021 09:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347687AbhERJGR (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 18 May 2021 05:06:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:64442 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347059AbhERJGR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 May 2021 05:06:17 -0400
IronPort-SDR: nYLQ6HLEAQQh/dYDfQt213Cf0HUFDNl1DB2EvG1oUAMTH7Qwnario/7MzdmxJocS4NycSZ6AJA
 dm3Ik6QlcJzQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="200713044"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="200713044"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 02:04:49 -0700
IronPort-SDR: Spi/UWEIEn9/3zqg8BWA2pMMYXkEkRk2EJTww5qAg6h7q8OeAVQh0ZERfo1Np+7IUGZl6lLI+F
 mCOyrjbaNlXA==
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="611902819"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 02:04:45 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1livec-00CuXF-D6; Tue, 18 May 2021 12:04:42 +0300
Date:   Tue, 18 May 2021 12:04:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 1/5 v2] iio: st_sensors: Create extended attr macro
Message-ID: <YKODKkJZZVwc1Ec1@smile.fi.intel.com>
References: <20210517233322.383043-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517233322.383043-1-linus.walleij@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 18, 2021 at 01:33:18AM +0200, Linus Walleij wrote:
> Extend ST_SENSORS_LSM_CHANNELS() to a version that will accept extended
> attributes named ST_SENSORS_LSM_CHANNELS_EXT() and wrap the former as a
> specialized version of the former.

Missed to Cc Hans?

Btw, I have scripted the series submission [1]. Feel free to use it, I found it
much easier and less error prone (like forgetting maintainers or key contributors).

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko


