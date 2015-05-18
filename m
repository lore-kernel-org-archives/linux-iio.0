Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-025.synserver.de ([212.40.185.25]:1054 "EHLO
	smtp-out-023.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751734AbbERQyU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2015 12:54:20 -0400
Message-ID: <555A1938.6070502@metafoo.de>
Date: Mon, 18 May 2015 18:54:16 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>, jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
CC: knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Introduce PM runtime helper functions
References: <1431966328-11058-1-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1431966328-11058-1-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/18/2015 06:25 PM, Daniel Baluta wrote:
> Working on a new driver I noticed that there is a fair amount of duplicate
> code for adding PM runtime support.
>
> First patch refactors the PM runtime support in a new header
>   <linux/iio/pm_runtime> introducing functions for setup/cleanup and
> set power state.

Makes sense, but none of the functions look awfully IIO specific. I'd say 
these are helper functions that belong into the PM core itself.

- Lars
