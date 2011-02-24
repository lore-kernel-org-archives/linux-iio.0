Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com, jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org
Subject: Driver timestamp handling updates
Date: Thu, 24 Feb 2011 22:19:46 +0100
Message-ID: <1298582390-8999-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This series of patches fixes a lack of IIO ABI updates on the drivers addressed.
The timestamps are now treated as valid channel information, and can be fully controlled,
whether they are part of the ring buffer scans or not.
