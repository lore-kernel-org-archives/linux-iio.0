Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:36364 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001AbbD0Py4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2015 11:54:56 -0400
Received: by wgen6 with SMTP id n6so120801184wge.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2015 08:54:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <64714.10.254.87.235.1430149342.squirrel@linux.intel.com>
References: <1430146908-27919-1-git-send-email-octavian.purdila@intel.com>
	<1430146908-27919-4-git-send-email-octavian.purdila@intel.com>
	<64714.10.254.87.235.1430149342.squirrel@linux.intel.com>
Date: Mon, 27 Apr 2015 18:54:54 +0300
Message-ID: <CAE1zot+YKTPmVbG-_fNRy-E_VCcqq1VE78H3PMSMb5HvsBheQw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] iio: derive the mounting matrix from ACPI _PLD objects
From: Octavian Purdila <octavian.purdila@intel.com>
To: sathyanarayanan.kuppuswamy@linux.intel.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Robert Moore <robert.moore@intel.com>,
	Rafael J Wysocki <rafael.j.wysocki@intel.com>,
	lenb@kernel.org, linux-api@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Apr 27, 2015 at 6:42 PM, Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> Since Acpi framework already exports this info to user space, Why not do
> this derivation in user space code ? Why do we need new ABI, if the same
> can be derived from existing one.
>

The ABI was added in the previous patch so that we can present the
sensor orientation information to userspace even in the case of device
tree.

The purpose of this patch is to provide a consistent ABI to userspace,
i.e. to avoid doing one thing in the ACPI case and another thing in
the case of device tree.
