Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:38843 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752360AbdLDKlp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 4 Dec 2017 05:41:45 -0500
Date: Mon, 4 Dec 2017 12:41:40 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Jeremy Cline <jeremy@jcline.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars Kellogg-Stedman <lars@oddbit.com>,
        Steven Presser <steve@pressers.name>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] iio: accel: bmc150: Check for a second ACPI device
 for BOSC0200
Message-ID: <20171204104140.GZ22431@lahna.fi.intel.com>
References: <20171129223016.17848-1-jeremy@jcline.org>
 <0100016009e7c30a-407c2980-d8d5-4506-ab47-d0fb2fed481d-000000@email.amazonses.com>
 <20171202121927.3b7aa028@archlinux>
 <20171204095819.GY22431@lahna.fi.intel.com>
 <045185e0-927e-f004-2ec6-44205e5f6c13@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <045185e0-927e-f004-2ec6-44205e5f6c13@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Dec 04, 2017 at 11:29:31AM +0100, Hans de Goede wrote:
> i2c_new_secondary_device() is for a different purpose, this is for when
> a single i2c device listens on multiple addresses and the driver wants
> separate i2c_client-s to use to talk to each address.
> 
> In this case there are 2 separate devices, not a single device listening
> on multiple addresses.  Something like i2c_new_secondary_device() ACPI
> support might be useful for i2c devices where a single device / "IC" listens
> on multiple addresses and all these addresses are listed in the ACPI resource
> table, but not for this specific case.

Right, thanks Hans for correcting me.
