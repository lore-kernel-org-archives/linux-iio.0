Return-Path: <jikos@kernel.org>
Date: Sat, 5 Nov 2016 16:58:17 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: "Ooi, Joyce" <joyce.ooi@intel.com>
cc: Jonathan Cameron <jic23@kernel.org>,
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
    Benjamin Tissoires <benjamin.tissoires@redhat.com>,
    linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
    linux-kernel@vger.kernel.org, Kweh Hock Leong <hock.leong.kweh@intel.com>,
    Ong Boon Leong <boon.leong.ong@intel.com>,
    Lay Kuan Loon <kuan.loon.lay@intel.com>
Subject: Re: [PATCH] hid: sensor: fix input and feature attributes in HID
 sensor custom sysfs interface
In-Reply-To: <1478170515-24436-1-git-send-email-joyce.ooi@intel.com>
Message-ID: <alpine.LNX.2.00.1611051657590.29400@cbobk.fhfr.pm>
References: <1478170515-24436-1-git-send-email-joyce.ooi@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Thu, 3 Nov 2016, Ooi, Joyce wrote:

> User is unable to access to input-X-yyy and feature-X-yyy where
> X is a hex value and more than 9 (e.g. input-a-yyy, feature-b-yyy) in HID
> sensor custom sysfs interface.
> This is because when creating the attribute, the attribute index is
> written to using %x (hex). However, when reading and writing values into
> the attribute, the attribute index is scanned using %d (decimal). Hence,
> user is unable to access to attributes with index in hex values
> (e.g. 'a', 'b', 'c') but able to access to attributes with index in
> decimal values (e.g. 1, 2, 3,..).
> This fix will change input-%d-%x-%s and feature-%d-%x-%s to input-%x-%x-%s
> and feature-%x-%x-%s in show_values() and store_values() accordingly.
> 
> Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>

Applied to hid.git#for-4.9/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs
