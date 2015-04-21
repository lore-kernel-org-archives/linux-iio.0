Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26787 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933519AbbDUQ0A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 21 Apr 2015 12:26:00 -0400
Message-ID: <55367A8B.3050907@intel.com>
Date: Tue, 21 Apr 2015 19:27:55 +0300
From: Daniel Baluta <daniel.baluta@intel.com>
MIME-Version: 1.0
To: sathyanarayanan.kuppuswamy@linux.intel.com
CC: jic23@kernel.org, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH v8 2/2] iio: ltr501: Add support for ltr301 chip
References: <1429632660-8716-1-git-send-email-daniel.baluta@intel.com>    <1429632660-8716-3-git-send-email-daniel.baluta@intel.com> <50554.10.252.192.198.1429633391.squirrel@linux.intel.com>
In-Reply-To: <50554.10.252.192.198.1429633391.squirrel@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 04/21/2015 07:23 PM, Kuppuswamy Sathyanarayanan wrote:
> Hi Jonathan,
>
> Please don't push this patchset until I test it. I will let you know once
> I am done.
>

Hi Sathya,

Do you use ACPI, device tree or i2c-sysfs for device discovery?

In particular how do you specify client->irq?

thanks,
Daniel.
