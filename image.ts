export class Image{
    id: number;
    title: string;
    keywords: string[];
    id_collection: number;
    height: number;
    width: number;
    date_publish: Date;
    download: number;
    file_name: string;
}

module.exports = { Image }