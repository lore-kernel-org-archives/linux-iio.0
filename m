Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933631AbcKDODO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 4 Nov 2016 10:03:14 -0400
Date: Fri, 4 Nov 2016 15:03:08 +0100
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: "Ooi, Joyce" <joyce.ooi@intel.com>
Cc: Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kweh Hock Leong <hock.leong.kweh@intel.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Lay Kuan Loon <kuan.loon.lay@intel.com>
Subject: Re: [PATCH] hid: sensor: fix input and feature attributes in HID
 sensor custom sysfs interface
Message-ID: <20161104140308.GC20334@mail.corp.redhat.com>
References: <1478170515-24436-1-git-send-email-joyce.ooi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1478170515-24436-1-git-send-email-joyce.ooi@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Nov 03 2016 or thereabouts, Ooi, Joyce wrote:
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

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

